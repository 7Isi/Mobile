import 'package:flutter/material.dart';

import 'package:sa03_app_navegacao_cadastro/view/tela_cadastro.dart';
import 'package:sa03_app_navegacao_cadastro/view/tela_confirmacao.dart';
import 'package:sa03_app_navegacao_cadastro/view/tela_inicial.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
  routes: {
    "/":(context) => TelaInicial(),
    "/cadastro": (context) => TelaCadastro(),
    "/confirmacao": (contex) => TelaConfirmacao(),
    },

    initialRoute: "/",
  ));
}
