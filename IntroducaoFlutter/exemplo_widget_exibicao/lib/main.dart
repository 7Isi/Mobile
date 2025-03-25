import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: 
    MyApp(),
    debugShowCheckedModeBanner: false
    ));
}


//Contrução da Janela
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget de Exibição"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Olá, Flutter!!!", 
            style: TextStyle(
            fontSize: 20, 
            color: Colors.blueAccent)),

            Text("Flutter é coisa de bobão",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              letterSpacing: 1.5
            ),),

            Icon(Icons.star, size:65, color: Colors.lime,),
            IconButton(
              onPressed: () => print("Me Aperto, Oloco"),
              icon: Icon(Icons.notifications, size:50)),

            Image.network("https://64.media.tumblr.com/e45ccc414db99cbc3761d6ad3e94da9c/ad345d9b59d34501-0f/s1280x1920/b0b7a0e6deb8ccfcc14186fd6a07923801b0ce72.png",
            height: 300,
            width: 300,
            fit: BoxFit.cover,),

            Image.asset("assets/img/viTATTOO.png",
            height: 300,
            width: 300,
            fit: BoxFit.cover,)
          ],
        ),
      )
    );
  }
}