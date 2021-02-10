// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

/// The contents of a native zero-terminated array of UTF-16 code units.
///
/// The Utf16 type itself has no functionality, it's only intended to be used
/// through a `Pointer<Utf16>` representing the entire array. This pointer is
/// the equivalent of a char pointer (`const wchar_t*`) in C code. The
/// individual UTF-16 code units are stored in native byte order.
class Utf16 extends Opaque {
  /// Creates a zero-terminated [Utf16] code-unit array from [string].
  ///
  /// If [string] contains NUL characters, the converted string will be truncated
  /// prematurely.
  ///
  /// Returns an [allocator]-allocated pointer to the result.
  @Deprecated('Use StringUtf16Pointer.toNativeUtf16 instead.')
  static Pointer<Utf16> toUtf16(String string, {Allocator allocator = calloc}) {
    return string.toNativeUtf16(allocator: allocator);
  }
}

extension Utf16Pointer on Pointer<Utf16> {
  /// The number of UTF-16 code units in this zero-terminated UTF-16 string.
  ///
  /// The UTF-16 code units of the strings are the non-zero code units up to
  /// the first zero code unit.
  int get length {
    final Pointer<Uint16> array = cast<Uint16>();
    int length = 0;
    while (array[length] != 0) {
      length++;
    }
    return length;
  }

  /// Converts this UTF-8 encoded string to a Dart string.
  ///
  /// Decodes the UTF-16 code units of this zero-terminated code unit array as
  /// Unicode code points and creates a Dart string containing those code
  /// points.
  ///
  /// If [length] is provided, zero-termination is ignored and the result can
  /// contain NUL characters.
  String toDartString({int? length}) {
    if (length != null) {
      RangeError.checkNotNegative(length, 'length');
    } else {
      length = this.length;
    }

    final buffer = StringBuffer();
    final pointer = cast<Uint16>();

    for (var v = 0; v < length; v++) {
      final charCode = pointer.elementAt(v).value;
      buffer.writeCharCode(charCode);
    }
    return buffer.toString();
  }
}

extension StringUtf16Pointer on String {
  /// Creates a zero-terminated [Utf16] code-unit array from this String.
  ///
  /// If this [String] contains NUL characters, the converted string will be
  /// truncated prematurely.
  ///
  /// Returns an [allocator]-allocated pointer to the result.
  Pointer<Utf16> toNativeUtf16({Allocator allocator = calloc}) {
    final units = codeUnits;
    final Pointer<Uint16> result = allocator<Uint16>(units.length + 1);
    final Uint16List nativeString = result.asTypedList(units.length + 1);
    nativeString.setAll(0, units);
    nativeString[units.length] = 0;
    return result.cast();
  }
}
