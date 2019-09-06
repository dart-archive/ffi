// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

/// [Utf8] implements conversion between Dart strings and null-termianted
/// Utf8-encoded "char*" strings in C.
//
// TODO(https://github.com/dart-lang/sdk/issues/38172): No need to use
// 'asExternalTypedData' when Pointer operations are performant.
class Utf8 extends Struct<Utf8> {
  /// Creates a [String] containing the characters UTF-8 encoded in [string].
  ///
  /// The [string] must be a zero-terminated byte sequence of valid UTF-8
  /// encodings of Unicode code points. It may also contain UTF-8 encodings of
  /// unpaired surrogate code points, which is not otherwise valid UTF-8, but
  /// which may be created when encoding a Dart string containing an unpaired
  /// surrogate.
  ///
  /// Returns a Dart string containing the decoded code points.
  static String fromUtf8(Pointer<Utf8> string) {
    final Pointer<Uint8> array = string.cast<Uint8>();
    int count = 0x1000;
    Uint8List nativeString = array.asExternalTypedData(count: count);
    int i = 0;
    while (nativeString[i] != 0) {
      if (++i == count) {
        count *= 2;
        nativeString = array.asExternalTypedData(count: count);
      }
    }
    return utf8.decode(Uint8List.view(nativeString.buffer, 0, i));
  }

  /// Convert a [String] to a Utf8-encoded null-terminated C string.
  ///
  /// If 'string' contains NULL bytes, the converted string will be truncated
  /// prematurely.
  static Pointer<Utf8> toUtf8(String string) {
    final units = utf8.encode(string);
    final Pointer<Uint8> result =
        Pointer<Uint8>.allocate(count: units.length + 1);
    final Uint8List nativeString =
        result.asExternalTypedData(count: units.length + 1);
    nativeString.setAll(0, units);
    nativeString[units.length] = 0;
    return result.cast();
  }

  String toString() => fromUtf8(addressOf);
}
