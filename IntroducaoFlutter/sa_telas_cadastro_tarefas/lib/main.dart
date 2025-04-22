import 'package:flutter/material.dart';

import 'package:sa_telas_cadastro_tarefas/views/tela_cadastro.dart';
import 'package:sa_telas_cadastro_tarefas/views/tela_tarefas.dart';
import 'package:sa_telas_cadastro_tarefas/views/tela_inicial.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
  routes: {
    "/":(context) => TelaInicial(),
    "/cadastro": (context) => TelaCadastro(),
    "/tarefas": (contex) => TelaTarefas(),
    },

    initialRoute: "/",
  ));
}
