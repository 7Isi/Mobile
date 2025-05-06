import 'package:exemplo_shared_preferences/Tela_ToDo_Lista.dart';
import 'package:flutter/material.dart';

import 'telainicial.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    theme: ThemeData(brightness: Brightness.light),
    darkTheme: ThemeData(brightness: Brightness.dark),

    routes: {
      "/tarefas": (context) => TelaTodoList(),
      "/": (context) => TelaInicial(),
    },
  ),);
}
