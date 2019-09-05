// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library utf8;

import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

/// [Utf8] implements conversion between Dart strings and null-termianted
/// Utf8-encoded "char*" strings in C.
class Utf8 extends Struct<Utf8> {
  static String fromUtf8(Pointer<Utf8> str) {
    final Pointer<Uint8> array = str.cast();
    int count = 0x1000;
    Uint8List string = array.asExternalTypedData(count: count);
    int i = 0;
    for (; string[i] != 0; ++i) {
      if (i == count) {
        count *= 2;
        string = array.asExternalTypedData(count: count);
      }
    }
    return Utf8Decoder().convert(Uint8List.view(string.buffer, 0, i));
  }

  static Pointer<Utf8> toUtf8(String s) {
    final List<int> units = Utf8Encoder().convert(s);
    final Pointer<Uint8> result =
        Pointer<Uint8>.allocate(count: units.length + 1);
    final Uint8List string =
        result.asExternalTypedData(count: units.length + 1);
    string.setAll(0, units);
    string[units.length] = 0;
    return result.cast();
  }

  String toString() => fromUtf8(addressOf);
}
