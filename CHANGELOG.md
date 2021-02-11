# Changelog

## 1.0.0

Bumping the version of this package to `1.0.0`.

Removes all deprecated methods, use `0.3.0-nullsafety.3` for migration.

## 0.3.1-nullsafety.0

Deprecates the static methods on `Utf8` and `Utf16` and introduces
extension methods to replace them.

## 0.3.0-nullsafety.3

Adds back in deprecated `allocate` and `free` to ease migration.
These will be removed in the next release.

This pre-release requires Dart `2.12.0-259.9.beta` or greater.

## 0.3.0-nullsafety.1

This pre-release requires Dart `2.12.0-259.8.beta` or greater.

Note that this pre-release does _not_ work in Flutter versions containing Dart
`2.12.0-260.0.dev` - `2.12.0-264.0.dev`.
Using `Allocator.call` throws a `NoSuchMethodError` in these versions.
See [Flutter Engine #23954](https://github.com/flutter/engine/pull/23954) for more info.

## 0.3.0-nullsafety.0

Changes `Utf8` and `Utf16` to extend `Opaque` instead of `Struct`.
This means `.ref` is no longer available and `Pointer<Utf(..)>` should be used.
See [breaking change #44622](https://github.com/dart-lang/sdk/issues/44622) for more info.

Removes `allocate` and `free`.
Instead, introduces `calloc` which implements the new `Allocator` interface.
See [breaking change #44621](https://github.com/dart-lang/sdk/issues/44621) for more info.

This pre-release requires Dart `2.12.0-265.0.dev` or greater.

## 0.2.0-nullsafety.1

Adds an optional named `length` argument to `Utf8.fromUtf8()`.

## 0.2.0-nullsafety.0

Pre-release (non-stable) release supporting null safety.
Requires Dart 2.12.0 or greater.

## 0.1.3

Stable release incorporating all the previous dev release changes.

Bump SDK constraint to `>= 2.6.0`.

## 0.1.3-dev.4

Bump SDK constraint to `>= 2.6.0-dev.8.2` which contains the new API of `dart:ffi`.

## 0.1.3-dev.3

Replace use of deprecated `asExternalTypedData` with `asTypedList`.

## 0.1.3-dev.2

Incorporate struct API changes, drop type argument of structs.

## 0.1.3-dev.1

* Adds top-level `allocate<T>()` and `free()` methods which can be used as a
  replacement for the deprecated `Pointer.allocate<T>()` and `Pointer.free()`
  members in `dart:ffi`.

## 0.1.1+2

* Expand readme

## 0.1.1+1

* Fix documentation link

## 0.1.1

* Add basic Utf16 support

## 0.1.0

* Initial release supporting Utf8
