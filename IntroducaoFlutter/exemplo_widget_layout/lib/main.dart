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
      appBar: AppBar (title: Text("Exemplo de Layout"),),
      body: Container (
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: const Color.fromARGB(255, 30, 49, 135),
                  height: 400,
                  width: 300,
                ),
                Container(
                  color: Colors.red,
                  height: 300,
                  width: 200,
                ),
                Icon(Icons.person, size: 100)
              ],
            ),

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
                  color: Colors.lightGreen,
                  height: 100,
                  width: 100,
                ),
              ],
            ),

            Text("Um Texto Qualquer"),
          ],),
      )
    );
  }
}
