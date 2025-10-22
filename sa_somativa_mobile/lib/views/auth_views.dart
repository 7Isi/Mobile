import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_somativa_mobile/views/login_views.dart';
import 'package:sa_somativa_mobile/views/point_views.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>( //widget de construção de telas a partir de uma tomada de decisão
      //a mudança de tela é determinada pela conexão do usuário ao firebase
      stream: FirebaseAuth.instance.authStateChanges(),// mudança de status do usuario
      builder: (context, snapshot){
        if(snapshot.hasData){
          //Se o Snapshot tem dados do usuário, significa que o usuário está logando
          return PointView();
        }
        //Caso contrário
        return LoginView();
      }
    );
  }
}