




import 'package:zero_size_encryption/zero_size_encryption.dart';

extension Encryptor on ZeroSizeEncryptorDecryptor {


  List<int> encrypt({String? key}){
    key??=this.key;
    assert(key!=null);
    return List.generate(bytes.length,(i)=>_handleSingleByte(bytes[i], key!));
  }
  void encryptOriginal({String? key}){
    key??=this.key;
    assert(key!=null);

    for (int i = 0; i < bytes.length ; i++){
      int byte = bytes[i];
      byte = _handleSingleByte(byte, key!);
      bytes[i] = byte;
    }
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


  List<int> decrypt({String? key}){
    key??=this.key;
    assert(key!=null);
    return List.generate(bytes.length,(i)=>_handleSingleByteMinus(bytes[i], key!));
  }
  void decryptOriginal({String? key}){
    key??=this.key;
    assert(key!=null);

    for (int i = 0; i < bytes.length ; i++){
      int byte = bytes[i];
      byte = _handleSingleByteMinus(byte, key!);
      bytes[i] = byte;
    }
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
    int result = this;
    while(result > 255) {
      result -=255;
    }
    while(result<0){
      result+=255;
    }
    return result;
  }
}

