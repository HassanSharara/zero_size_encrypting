




import 'package:zero_size_encryption/zero_size_encryption.dart';

extension Encryptor on ZeroSizeEncryptorDecryptor {


  List<int> encrypt({String? key, int? toEncryptLength}){
    key??=this.key;
    assert(key!=null);
    toEncryptLength??=bytes.length;
    for (int i = 0; i < toEncryptLength ; i++){
      int byte = bytes[i];
      byte = _handleSingleByte(byte, key!);
      bytes[i] = byte;
    }
    return bytes;
  }

  int _handleSingleByte(int byte,final String key){
    for(final int keyBytes in key.codeUnits){
      byte+=keyBytes;
      byte = byte._reShape();
    }
    return byte;
  }

}



extension Decryptor on ZeroSizeEncryptorDecryptor {


  List<int> decrypt({String? key,int? toDecryptLength}){
    key??=this.key;
    assert(key!=null);
    toDecryptLength??=bytes.length;
    for (int i = 0; i < toDecryptLength ; i++){
      int byte = bytes[i];
      byte = _handleSingleByteMinus(byte, key!);
      bytes[i] = byte;
    }
    return bytes;
  }

  int _handleSingleByteMinus(int byte,final String key){
    
    for(final int keyBytes in key.codeUnits){
      byte-=keyBytes;
      byte = byte._reShape();
    }
    return byte;
  }

}
extension Modifiers on int {

  int _reShape(){
    return this % 256;
  }
}

