import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp()); //class
}

//extends - busca de herença duma superclasse
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Explo de PubSpec")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Olá Mundo",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER_LEFT);
            },
            child: Text("Aperta o Botão"),),
        ),
      ), //suporte para aplicações
    );
  }
}
