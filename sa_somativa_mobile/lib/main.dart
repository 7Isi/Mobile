import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sa_somativa_mobile/views/registro_views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // garante que tudo está pronto para inicializar o Firebase
  await Firebase.initializeApp(); // inicializa o Firebase antes do runApp
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistroView(),
    );
  }
}
