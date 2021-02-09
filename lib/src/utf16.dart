// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

/// [Utf16] implements conversion between Dart strings and zero-terminated
/// UTF-16 encoded "char*" strings in C.
///
/// [Utf16] is represented as [Opaque] so that `Pointer<Utf16>` can be used in
/// native function signatures.
class Utf16 extends Opaque {
  /// Convert a [String] to a UTF-16 encoded zero-terminated C string.
  ///
  /// If [string] contains NULL characters, the converted string will be truncated
  /// prematurely. Unpaired surrogate code points in [string] will be preserved
  /// in the UTF-16 encoded result. See [Utf16Encoder] for details on encoding.
  ///
  /// Returns a [allocator]-allocated pointer to the result.
  @Deprecated('Use StringUtf16Pointer.toUtf16 instead.')
  static Pointer<Utf16> toUtf16(String string, {Allocator allocator = calloc}) {
    return string.toUtf16(allocator: allocator);
  }
}

extension Utf16Pointer on Pointer<Utf16> {
  /// Creates a [String] containing the characters UTF-16 encoded in this
  /// Pointer.
  String toDartString(int maxLength) {
    final buffer = StringBuffer();
    final pointer = Pointer<Uint16>.fromAddress(address);

    for (var v = 0; v < maxLength; v++) {
      final charCode = pointer.elementAt(v).value;
      if (charCode != 0) {
        buffer.write(String.fromCharCode(charCode));
      } else {
        return buffer.toString();
      }
    }
    return buffer.toString();
  }
}

extension StringUtf16Pointer on String {
  /// Convert a [String] to a UTF-16 encoded zero-terminated C string.
  ///
  /// If [string] contains NULL characters, the converted string will be truncated
  /// prematurely. Unpaired surrogate code points in [string] will be preserved
  /// in the UTF-16 encoded result. See [Utf16Encoder] for details on encoding.
  ///
  /// Returns a [allocator]-allocated pointer to the result.
  Pointer<Utf16> toUtf16({Allocator allocator = calloc}) {
    final units = codeUnits;
    final Pointer<Uint16> result = allocator<Uint16>(units.length + 1);
    final Uint16List nativeString = result.asTypedList(units.length + 1);
    nativeString.setAll(0, units);
    nativeString[units.length] = 0;
    return result.cast();
  }
}
