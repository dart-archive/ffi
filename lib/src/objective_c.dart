// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This library defines [NativeType]s for some core Objective C types.

import 'dart:ffi';

/// The Objective C `NSObject` type.
///
/// `NSObject` is always passed around by pointer, so use `Pointer<ObjCObject>`.
/// The `id` type also maps to `Pointer<ObjCObject>`.
class ObjCObject extends Opaque {}

/// The Objective C `Class` type.
///
/// `Class` is always passed around by pointer, so use `Pointer<ObjCClass>`.
class ObjCClass extends ObjCObject {}

/// The Objective C `Block` type.
///
/// `Block` is always passed around by pointer, so use `Pointer<ObjCBlock>`. The
/// type parameter describes the call signature of the `Block`.
class ObjCBlock<F extends Function> extends ObjCObject {}

/// The implementation of the Objective C `SEL` type.
///
/// This type is not used directly. Instead, the `SEL` type maps to
/// `Pointer<ObjCSel>`.
class ObjCSel extends Opaque {}
