import 'package:cine_favorite/views/favorite_view.dart';
import 'package:cine_favorite/views/login_view.dart';
import 'package:flutter/material.dart';
import 'dart:ui/window.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  //garantir o carregamento dos widgets primeiro
  WidgetsFlutterBinding.ensureInitialized();

  //conectar com o firebase
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Cine Favorite",
    theme: ThemeData(
      primarySwatch: Colors.orange,
      brightness: Brightness.dark,
    ),
    home: AuthStream(),

    )
  );
}


class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {

    //ouvinte de mudança de estado (listener)
    return StreamBuilder<User?>( //retorna o status do usuario (nulo ou logado)
      stream: FirebaseAuth.instance.authStateChanges(), //indentifica a mudança de status do usuario
      builder: (context, snapshot){ //analisa o instantâneo da aplicação

      //se tiver logado, vai para a tela de favoritos
      if(snapshot.hasData){
        return FavoriteView();
      }
      return LoginView();
      }
    );
  }
}