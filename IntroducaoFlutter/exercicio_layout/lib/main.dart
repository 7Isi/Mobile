import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      //routes - rotas de navegação +1 tela
    ),
  );
}

//Janela para estudo de layout (Columns, Rows, Stacks, Containers)

class MyApp extends StatelessWidget {
  //Sobrescrever o método build
  @override
  Widget build(BuildContext context) {
    return Scaffold( //suporte da janela (appbar, body, bottonNB, drawer)
      appBar: AppBar (title: Text("Execício de Layout e Exibição"),),
      body: Container (
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: const Color.fromARGB(192, 61, 70, 112),
                  height: 320,
                  width: 320,
                ),
                Container(
                  color: const Color.fromARGB(138, 207, 213, 192),
                  height: 300,
                  width: 300,
                ),

                Image.asset("assets/img/cavaleirin.png",
                  height: 270,
                  width: 270,
                  fit: BoxFit.cover,
                ),
              ],
            ),
              
              Text("ARTHUR C.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold),),


              Text("Carazinho, RS",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.blueAccent,
                  height: 100,
                  width: 100,
                ),

                Container(
                  color: Colors.indigoAccent,
                  height: 100,
                  width: 100,
                ),

                Container(
                  color: Colors.lightBlueAccent,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
        ],),
      )
    );
  }
}
