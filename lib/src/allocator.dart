// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

abstract class Allocator {
  Pointer<Int8> allocate(int bytes);
}

class MallocAllocator implements Allocator {
  Pointer<Int8> allocate(int bytes) =>
      Pointer<Int8>.allocate(count: bytes).cast();
}
