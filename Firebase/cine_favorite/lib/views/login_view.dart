import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cine_favorite/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance; //controller para autenticar usuários na plataforma do FireBase
  final _emailFild = TextEditingController(); //controlador de edição de texto
  final _senhaFild = TextEditingController();
  bool _senhaOculta = true;

  //método de Login
  void _login() async{
    try {
      //solicitar a autenticação do usuário
      await _auth.signInWithEmailAndPassword(
        email: _emailFild.text.trim(),
        password: _senhaFild.text);
      //não precisa de Navigator, pois o AuthVoew(StreamBuilder)
      //já faz o direcionamento ao modificar o status do Usuário
    } catch (e) {  //tratamento mais especifico
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao fazer Login"))
      );
    }
  }

  //build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              controller: _emailFild,
              decoration: InputDecoration(labelText: "E-Mail"),
              keyboardType: TextInputType.emailAddress,
            ),

            TextField(
              controller: _senhaFild,
              decoration: InputDecoration(
                labelText: "Digite a Senha",
                suffixIcon: IconButton(
                  onPressed: ()=>{
                    setState(() {
                      _senhaOculta = !_senhaOculta;
                    })
                  },
                  icon: _senhaOculta ? Icon(Icons.visibility) : Icon(Icons.visibility_off))
                ),
              obscureText: _senhaOculta,
            ),

            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _login,
              child: Text("Login")),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistroView()));
                },
                child: Text("Não tem uma conta? Registre-se"))
          ],
        ),
      ),
    );
  }
}