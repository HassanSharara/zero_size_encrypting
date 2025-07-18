import 'dart:typed_data';

final class ZeroSizeEncryptorDecryptor {
  final List<int> bytes;
  final String? key;
  const ZeroSizeEncryptorDecryptor._(this.bytes,{this.key});

  factory ZeroSizeEncryptorDecryptor.fromList(List<int> bytes,{final String? key}) =>
      ZeroSizeEncryptorDecryptor._(bytes,key:key);

  factory ZeroSizeEncryptorDecryptor.fromUnits(Uint8List bytes,{final String? key}) =>
      ZeroSizeEncryptorDecryptor.fromList(bytes.toList(),key:key);

  factory ZeroSizeEncryptorDecryptor.fromString(String data,{final String? key}) =>
      ZeroSizeEncryptorDecryptor.fromList(data.codeUnits,key:key);

  static ZeroSizeEncryptorDecryptor? fromDynamic(dynamic data,{final String? key}) {
    switch (data) {
      case String s:
        return ZeroSizeEncryptorDecryptor.fromString(s,key: key);
      case Uint8List u:
        return ZeroSizeEncryptorDecryptor.fromUnits(u,key: key);
      case List<int> l:
        return ZeroSizeEncryptorDecryptor.fromList(l,key: key);
      default:
        return null;
    }
  }
}

