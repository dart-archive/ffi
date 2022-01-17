// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

// `signed char` in C.
typedef SignedChar = Int8;

// `unsigned char` in C.
typedef UnsignedChar = Uint8;

// `short` in C.
typedef Short = Int16;

// `unsigned short` in C.
typedef UnsignedShort = Uint16;

// `int` in C.
typedef Int = Int32;

// `unsigned int` in C.
typedef UnsignedInt = Uint32;

// `long long` in C.
typedef LongLong = Int64;

// `unsigned long long` in C.
typedef UnsignedLongLong = Uint64;

// `size_t` in C.
typedef Size = UintPtr;

// `ssize_t` in C.
typedef SSize = IntPtr;

// `off_t` in C.
typedef Off = Long;

/// `char` in C.
///
/// [Char] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
@AbiSpecificIntegerMapping({
  Abi.androidArm: Uint8(),
  Abi.androidArm64: Uint8(),
  Abi.androidIA32: Uint8(),
  Abi.androidX64: Uint8(),
  Abi.fuchsiaArm64: Int8(),
  Abi.fuchsiaX64: Int8(),
  Abi.iosArm: Int8(),
  Abi.iosArm64: Int8(),
  Abi.iosX64: Int8(),
  Abi.linuxArm: Int8(),
  Abi.linuxArm64: Int8(),
  Abi.linuxIA32: Int8(),
  Abi.linuxX64: Int8(),
  Abi.macosArm64: Int8(),
  Abi.macosX64: Int8(),
  Abi.windowsArm64: Int8(),
  Abi.windowsIA32: Int8(),
  Abi.windowsX64: Int8(),
})
class Char extends AbiSpecificInteger {
  const Char();
}

/// `uintptr_t` in C.
///
/// [UintPtr] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
@AbiSpecificIntegerMapping({
  Abi.androidArm: Uint32(),
  Abi.androidArm64: Uint64(),
  Abi.androidIA32: Uint32(),
  Abi.androidX64: Uint64(),
  Abi.fuchsiaArm64: Uint64(),
  Abi.fuchsiaX64: Uint64(),
  Abi.iosArm: Uint32(),
  Abi.iosArm64: Uint64(),
  Abi.iosX64: Uint64(),
  Abi.linuxArm: Uint32(),
  Abi.linuxArm64: Uint64(),
  Abi.linuxIA32: Uint32(),
  Abi.linuxX64: Uint64(),
  Abi.macosArm64: Uint64(),
  Abi.macosX64: Uint64(),
  Abi.windowsArm64: Uint64(),
  Abi.windowsIA32: Uint32(),
  Abi.windowsX64: Uint64(),
})
class UintPtr extends AbiSpecificInteger {
  const UintPtr();
}

/// `long` in C.
///
/// [Long] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
@AbiSpecificIntegerMapping({
  Abi.androidArm: Int32(),
  Abi.androidArm64: Int64(),
  Abi.androidIA32: Int32(),
  Abi.androidX64: Int64(),
  Abi.fuchsiaArm64: Int64(),
  Abi.fuchsiaX64: Int64(),
  Abi.iosArm: Int32(),
  Abi.iosArm64: Int64(),
  Abi.iosX64: Int64(),
  Abi.linuxArm: Int32(),
  Abi.linuxArm64: Int64(),
  Abi.linuxIA32: Int32(),
  Abi.linuxX64: Int64(),
  Abi.macosArm64: Int64(),
  Abi.macosX64: Int64(),
  Abi.windowsArm64: Int32(),
  Abi.windowsIA32: Int32(),
  Abi.windowsX64: Int32(),
})
class Long extends AbiSpecificInteger {
  const Long();
}

/// `unsigned long` in C.
///
/// [UnsignedLong] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
@AbiSpecificIntegerMapping({
  Abi.androidArm: Uint32(),
  Abi.androidArm64: Uint64(),
  Abi.androidIA32: Uint32(),
  Abi.androidX64: Uint64(),
  Abi.fuchsiaArm64: Uint64(),
  Abi.fuchsiaX64: Uint64(),
  Abi.iosArm: Uint32(),
  Abi.iosArm64: Uint64(),
  Abi.iosX64: Uint64(),
  Abi.linuxArm: Uint32(),
  Abi.linuxArm64: Uint64(),
  Abi.linuxIA32: Uint32(),
  Abi.linuxX64: Uint64(),
  Abi.macosArm64: Uint64(),
  Abi.macosX64: Uint64(),
  Abi.windowsArm64: Uint32(),
  Abi.windowsIA32: Uint32(),
  Abi.windowsX64: Uint32(),
})
class UnsignedLong extends AbiSpecificInteger {
  const UnsignedLong();
}

/// `wchar_t` in C.
///
/// The signedness of `wchar_t` is undefined in C. Here, it is exposed as an
/// unsigned integer.
///
/// [WChar] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
@AbiSpecificIntegerMapping({
  Abi.androidArm: Uint32(),
  Abi.androidArm64: Uint32(),
  Abi.androidIA32: Uint32(),
  Abi.androidX64: Uint32(),
  Abi.fuchsiaArm64: Uint32(),
  Abi.fuchsiaX64: Int32(),
  Abi.iosArm: Int32(),
  Abi.iosArm64: Int32(),
  Abi.iosX64: Int32(),
  Abi.linuxArm: Uint32(),
  Abi.linuxArm64: Uint32(),
  Abi.linuxIA32: Int32(),
  Abi.linuxX64: Int32(),
  Abi.macosArm64: Int32(),
  Abi.macosX64: Int32(),
  Abi.windowsArm64: Uint16(),
  Abi.windowsIA32: Uint16(),
  Abi.windowsX64: Uint16(),
})
class WChar extends AbiSpecificInteger {
  const WChar();
}
