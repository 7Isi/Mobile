//classes

import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( //1ª camada
      appBar: AppBar(title: Text("Tela Inicial, bem vindo!!"),centerTitle: true,),
      body: Center( //2ª camada
        child: Column( //3ª camada
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Aplicativo de Cadastro de Usuário",
            style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/cadastro"), 
              child: Text("Cadastro de Usuário"))
          ],
        ),
      ),
    );
  }
}
