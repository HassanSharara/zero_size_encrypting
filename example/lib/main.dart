
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zero_size_encryption/zero_size_encryption.dart';


void main(){
  runApp(const App());
}



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "test",
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  final TextEditingController dataController = TextEditingController();
  final TextEditingController keyController = TextEditingController()
    ..text = "HassanSharara";
  static const String _chars = "abcdefghijklmnopqrstuvwxyz1234567890";


  String encrypted = "";
  String decrypted = "";


  @override
  void initState() {
    dataController.text = _chars;
    super.initState();
  }



  _generateRandomText(){
    final List<String> n = _chars.
    split("")
        .toList()
    ..shuffle();
    dataController.text = n.join();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text("zero size encryption"),
      ),

      body:ListView(
        padding:const EdgeInsets.all(12),
        children: [

          const  Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text("DATA : ",
              style:TextStyle(fontWeight:FontWeight.bold,
                color:Colors.red
              ),
            ),
          ),
          TextFormField(
            controller:dataController,
          ),
          const SizedBox(height:10,),

          ElevatedButton(onPressed: _generateRandomText, child: const Text("generate random data text")),
          const SizedBox(height:20,),
          const  Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text("key : ",
              style:TextStyle(fontWeight:FontWeight.bold,
                  color:Colors.red
              ),
            ),
          ),
          TextFormField(
            controller:keyController,
          ),
          const SizedBox(height:20,),

          Text("encrypted : $encrypted"),
          const SizedBox(height:20,),
          Text("decrypted : $decrypted"),
          const SizedBox(height:80,),

          ElevatedButton(onPressed: (){
            final ZeroSizeEncryptorDecryptor
            encryptor = ZeroSizeEncryptorDecryptor.fromString(dataController.text,
             key:keyController.text
            );
            setState(() {
              encrypted = String.fromCharCodes(encryptor.encrypt(
              ));
            });

          }, child: Text("encrypt")),

          const SizedBox(height:20,),
          ElevatedButton(onPressed: (){
            final ZeroSizeEncryptorDecryptor
            decryptor = ZeroSizeEncryptorDecryptor.fromString(encrypted,
             key:keyController.text
            );

            setState(() {
              decrypted = String.fromCharCodes(decryptor.decrypt());
            });

            if(kDebugMode)print(decrypted == dataController.text);
          }, child: Text("decrypt")),

        ],
      ),
    );
  }
}



