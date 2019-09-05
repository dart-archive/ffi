// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:ffi/ffi.dart';

main() {
  test("fromUtf8 . toUtf8 is identity", () {
    final String start = "Hello World!\n";
    final String end = Utf8.fromUtf8(Utf8.toUtf8(start));
    expect(end, equals(start));
  });
}
