// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:test/test.dart';

void main() {
  test('uintptr_t', () {
    expect(sizeOf<UintPtr>(), sizeOf<IntPtr>());
  });

  test('wchar_t', () {
    final wcharSize = sizeOf<WChar>();
    if (Platform.isWindows) {
      expect(wcharSize, 2);
    } else {
      expect(wcharSize, 4);
    }
  });

  test('long', () {
    final longSize = sizeOf<Long>();
    if (Platform.isWindows) {
      expect(longSize, 4);
    } else {
      expect(longSize, sizeOf<IntPtr>());
    }
  });

  test('unsigned long', () {
    expect(sizeOf<UnsignedLong>(), sizeOf<Long>());
  });

  test('int', () {
    expect(sizeOf<Int>(), sizeOf<Int32>());
  });
}
