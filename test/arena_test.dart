// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:test/test.dart';

void main() async {
  test('sync', () async {
    List<int> freed = [];
    void freeInt(int i) {
      freed.add(i);
    }

    using((Arena arena) {
      arena.using(1234, freeInt);
      expect(freed.isEmpty, true);
    });
    expect(freed.length, 1);
    expect(freed.single, 1234);
  });

  test('async', () async {
    /// [using] waits with releasing its resources until after [Future]s
    /// complete.
    List<int> freed = [];
    void freeInt(int i) {
      freed.add(i);
    }

    Future<int> myFutureInt = using((Arena arena) {
      return Future.microtask(() {
        arena.using(1234, freeInt);
        return 1;
      });
    });

    expect(freed.isEmpty, true);
    await myFutureInt;
    expect(freed.length, 1);
    expect(freed.single, 1234);
  });

  test('throw', () {
    /// [using] waits with releasing its resources until after [Future]s
    /// complete.
    List<int> freed = [];
    void freeInt(int i) {
      freed.add(i);
    }

    // Resources are freed also when abnormal control flow occurs.
    bool didThrow = false;
    try {
      using((Arena arena) {
        arena.using(1234, freeInt);
        expect(freed.isEmpty, true);
        throw Exception('Some random exception');
      });
    } on Exception {
      expect(freed.single, 1234);
      didThrow = true;
    }
    expect(didThrow, true);
    expect(freed.single, 1234);
  });

  test(
    'allocate',
    () {
      final countingAllocator = CountingAllocator();
      // To ensure resources are freed, wrap them in a [using] call.
      using((Arena arena) {
        final p = arena<Int64>(2);
        p[1] = p[0];
      }, countingAllocator);
      expect(countingAllocator.numFrees, 1);
    },
  );

  test('allocate throw', () {
    // Resources are freed also when abnormal control flow occurs.
    bool didThrow = false;
    final countingAllocator = CountingAllocator();
    try {
      using((Arena arena) {
        final p = arena<Int64>(2);
        p[0] = 25;
        throw Exception('Some random exception');
      }, countingAllocator);
    } on Exception {
      expect(countingAllocator.numFrees, 1);
      didThrow = true;
    }
    expect(didThrow, true);
  });

  test('toNativeUtf8', () {
    final countingAllocator = CountingAllocator();
    using((Arena arena) {
      final p = 'Hello world!'.toNativeUtf8(allocator: arena);
      expect(p.toDartString(), 'Hello world!');
    }, countingAllocator);
    expect(countingAllocator.numFrees, 1);
  });

  test('zone', () async {
    List<int> freed = [];
    void freeInt(int i) {
      freed.add(i);
    }

    withZoneArena(() {
      zoneArena.using(1234, freeInt);
      expect(freed.isEmpty, true);
    });
    expect(freed.length, 1);
    expect(freed.single, 1234);
  });

  test('zone async', () async {
    /// [using] waits with releasing its resources until after [Future]s
    /// complete.
    List<int> freed = [];
    void freeInt(int i) {
      freed.add(i);
    }

    Future<int> myFutureInt = withZoneArena(() {
      return Future.microtask(() {
        zoneArena.using(1234, freeInt);
        return 1;
      });
    });

    expect(freed.isEmpty, true);
    await myFutureInt;
    expect(freed.length, 1);
    expect(freed.single, 1234);
  });

  test('zone throw', () {
    /// [using] waits with releasing its resources until after [Future]s
    /// complete.
    List<int> freed = [];
    void freeInt(int i) {
      freed.add(i);
    }

    // Resources are freed also when abnormal control flow occurs.
    bool didThrow = false;
    try {
      withZoneArena(() {
        zoneArena.using(1234, freeInt);
        expect(freed.isEmpty, true);
        throw Exception('Some random exception');
      });
    } on Exception {
      expect(freed.single, 1234);
      didThrow = true;
    }
    expect(didThrow, true);
    expect(freed.single, 1234);
  });

  test('allocate during releaseAll', () {
    final countingAllocator = CountingAllocator();
    final arena = Arena(countingAllocator);

    arena.using(arena<Uint8>(), (Pointer discard) {
      arena<Uint8>();
    });

    expect(countingAllocator.numAllocations, 1);
    expect(countingAllocator.numFrees, 0);

    arena.releaseAll(reuse: true);

    expect(countingAllocator.numAllocations, 2);
    expect(countingAllocator.numFrees, 2);
  });
}

/// Keeps track of the number of allocates and frees for testing purposes.
class CountingAllocator implements Allocator {
  final Allocator wrappedAllocator;

  int numAllocations = 0;
  int numFrees = 0;

  CountingAllocator([this.wrappedAllocator = calloc]);

  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) {
    numAllocations++;
    return wrappedAllocator.allocate(byteCount, alignment: alignment);
  }

  @override
  void free(Pointer<NativeType> pointer) {
    numFrees++;
    return wrappedAllocator.free(pointer);
  }
}
