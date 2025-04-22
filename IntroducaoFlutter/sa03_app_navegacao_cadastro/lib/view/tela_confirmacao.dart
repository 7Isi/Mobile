import 'package:flutter/material.dart';

class TelaConfirmacao extends StatelessWidget{
  const TelaConfirmacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Confirmação"),centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Cadastro Realizado com Sucesso"),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, "/"), 
                  label: Text("Home"),
                  icon: Icon(Icons.home),
                ),

                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, "/cadastro"),
                  label: Text("Novo cadastro"),
                  icon: Icon(Icons.person),)
              ],
            )
          ],
        ),
      ),
    );
  }
}