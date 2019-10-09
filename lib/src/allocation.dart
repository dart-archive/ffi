// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:io';

// Note that kernel32.dll is the correct name in both 32-bit and 64-bit.
final DynamicLibrary stdlib = Platform.isWindows
    ? DynamicLibrary.open("kernel32.dll")
    : DynamicLibrary.process();

typedef PosixMallocFn = Pointer Function(IntPtr);
typedef PosixMalloc = Pointer Function(int);
final PosixMalloc posixMalloc =
    stdlib.lookupFunction<PosixMallocFn, PosixMalloc>("malloc");

typedef PosixFreeFn = Void Function(Pointer);
typedef PosixFree = void Function(Pointer);
final PosixFree posixFree =
    stdlib.lookupFunction<PosixFreeFn, PosixFree>("free");

typedef WinGetProcessHeapFn = Pointer Function();
final WinGetProcessHeapFn winGetProcessHeap = stdlib
    .lookupFunction<WinGetProcessHeapFn, WinGetProcessHeapFn>("GetProcessHeap");
final Pointer processHeap = winGetProcessHeap();

typedef WinHeapAllocFn = Pointer Function(Pointer, Uint32, IntPtr);
typedef WinHeapAlloc = Pointer Function(Pointer, int, int);
final WinHeapAlloc winHeapAlloc =
    stdlib.lookupFunction<WinHeapAllocFn, WinHeapAlloc>("HeapAlloc");

typedef WinHeapFreeFn = Int32 Function(Pointer, Uint32, Pointer);
typedef WinHeapFree = int Function(Pointer, int, Pointer);
final WinHeapFree winHeapFree =
    stdlib.lookupFunction<WinHeapFreeFn, WinHeapFree>("HeapFree");

/// Allocates memory on the native heap.
///
/// For POSIX-based systems, this uses malloc. On Windows, it uses HeapAlloc
/// against the default public heap. Allocation of either element size or count
/// of 0 is undefined.
///
/// Throws an ArgumentError on failure to allocate.
Pointer<T> allocate<T extends NativeType>({int count = 1}) {
  final int totalSize = count * sizeOf<T>();
  Pointer<T> result;
  if (Platform.isWindows) {
    result = winHeapAlloc(processHeap, /*flags=*/ 0, totalSize).cast();
  } else {
    result = posixMalloc(totalSize).cast();
  }
  if (result == null) {
    throw ArgumentError("Could not allocate $totalSize bytes.");
  }
  return result;
}

/// Releases memory on the native heap.
///
/// For POSIX-based systems, this uses free. On Windows, it uses HeapFree
/// against the default public heap. It may only be used against pointers
/// allocated in a manner equivalent to [allocate].
///
/// Throws an ArgumentError on failure to free.
void free(Pointer pointer) {
  if (Platform.isWindows) {
    if (winHeapFree(processHeap, /*flags=*/ 0, pointer) == 0) {
      throw ArgumentError("Could not free $pointer.");
    }
  } else {
    posixFree(pointer);
  }
}
