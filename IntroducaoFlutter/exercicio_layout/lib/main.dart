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
  const MyApp({super.key});

  get child => null;

  //Sobrescrever o método build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //suporte da janela (appbar, body, bottonNB, drawer)
      appBar: AppBar(title: Text("Execício de Layout e Exibição")),
      body: Container(
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

                Image.asset(
                  "assets/img/cavaleirin.png",
                  height: 270,
                  width: 270,
                  fit: BoxFit.cover,
                ),
              ],
            ),

            Text(
              "Paffh A.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            Text(
              "Algum Lugar, CDC",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(color: Colors.blueAccent, height: 125, width: 125),

                Container(color: Colors.indigoAccent, height: 125, width: 125),

                Container(
                  color: Colors.lightBlueAccent,
                  height: 125,
                  width: 125,
                ),
              ],
            ),

            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Contatos"),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Carteira"),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Configuração"),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Privacidade"),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Suporte"),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
