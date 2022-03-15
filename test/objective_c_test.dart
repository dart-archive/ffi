// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:test/test.dart';

void main() {
  test('ObjCObject', () {
    expect(Pointer<ObjCObject>.fromAddress(0), isA<Pointer<Opaque>>());
  });

  test('ObjCClass', () {
    expect(Pointer<ObjCClass>.fromAddress(0), isA<Pointer<ObjCObject>>());
  });

  test('ObjCBlock', () {
    expect(Pointer<ObjCBlock<int Function(String)>>.fromAddress(0),
        isA<Pointer<ObjCObject>>());
    expect(Pointer<ObjCBlock<int Function(String)>>.fromAddress(0),
        isNot(isA<Pointer<ObjCBlock<String Function(int, int)>>>()));
  });

  test('ObjCSel', () {
    expect(Pointer<ObjCSel>.fromAddress(0), isA<Pointer<Opaque>>());
    expect(Pointer<ObjCSel>.fromAddress(0), isNot(isA<Pointer<ObjCObject>>()));
  });
}
