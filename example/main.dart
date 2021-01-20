import 'dart:ffi';

import 'package:ffi/ffi.dart' hide allocate;

void main() {
  // Allocate and free some native memory with malloc and free.
  final pointer = malloc<Uint8>();
  pointer.value = 3;
  print(pointer.value);
  malloc.free(pointer);

  // Use the Utf8 helper to encode zero-terminated UTF-8 strings in native memory.
  final String myString = '😎👿💬';
  final Pointer<Utf8> charPointer = Utf8.toUtf8(myString);
  print('First byte is: ${charPointer.cast<Uint8>().value}');
  print(Utf8.fromUtf8(charPointer));
  malloc.free(charPointer);
}
