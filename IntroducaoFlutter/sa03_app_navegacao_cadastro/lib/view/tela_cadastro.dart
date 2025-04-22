import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget{
  const TelaCadastro({super.key});
 // chamar as mudanças de estado
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro>{ // construir a tela 
  //sem formulário
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  double _idade = 0;
  bool _aceiteTermos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela de Cadastro"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nome"),
            TextField(controller: _nomeController),
            SizedBox(height: 20,),
            Text("Email"),
            TextField(controller: _emailController,),
            SizedBox(height: 20,),
            Text("Idade: ${_idade.toInt()}"),
            Slider(
              value: _idade,
              min: 0,
              max: 99,
              divisions: 99,
              label: _idade.round().toString(), 
              onChanged: (double valor)=>
                setState(() {
                  _idade = valor; 
              })),
            SizedBox(height: 20,),
            CheckboxListTile(
              value: _aceiteTermos,
              title: Text("Aceito os Termos do Cadastro"), 
              onChanged: (bool? valor)=>
              setState(() {
                _aceiteTermos = valor!;
              })),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _enviarCadastro, 
              child: Text("Enviar Cadastro"))
          ],
        ),),
    );    
  }

  void _enviarCadastro() {
    if(_nomeController.text.isEmpty || _emailController.text.isEmpty){
      _mostrarMensagem("Preencha Todos os Campos");
      return;
    }
    if(_idade<18){
      _mostrarMensagem("Não Permitido o Cadastro de Menor de Idade");
      return;
    }
    if (!_aceiteTermos) {
      _mostrarMensagem("Você Precisa aceitar os Termos");
    }
    Navigator.pushNamed(context, "/confirmacao");

  }
  
  void _mostrarMensagem(String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }
}