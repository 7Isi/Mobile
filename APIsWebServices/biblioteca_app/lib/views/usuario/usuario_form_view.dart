import 'package:biblioteca_app/controllers/usuario_controller.dart';
import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:biblioteca_app/views/home_view.dart';
import 'package:flutter/material.dart';

class UsuarioFormView extends StatefulWidget {
  //atributo
  final UsuarioModel? usuario;  //pode ser nulo

  const UsuarioFormView({super.key, this.usuario}); //usuario não é obrigatorio no construtor

  @override
  State<UsuarioFormView> createState() => _UsuarioFormViewState();
}

class _UsuarioFormViewState extends State<UsuarioFormView> {

  //atributos
  final _formKey = GlobalKey<FormState>();//validação do formulário
  final _controller = UsuarioController();//comunicação entre view e o model
  final _nomeField = TextEditingController(); //controlar o campo nome
  final _emailField = TextEditingController();//controllar o campo email

  @override
  void initState() {
    super.initState();
    if(widget.usuario != null){
      _nomeField.text = widget.usuario!.nome; 
      _emailField.text = widget.usuario!.email;
    }
  }

  //criar usuario
  void _criar() async{
    if(_formKey.currentState!.validate()){
      final usuarioNovo = UsuarioModel(
        id: DateTime.now().millisecond.toString(),
        nome: _nomeField.text.trim(), 
        email: _emailField.text.trim()
      );

      try {
        await _controller.create(usuarioNovo);
        //mensagem para o usuário
      } catch (e) {
        //mensagem de erro incrivel
      }

      Navigator.pop(context); //volta para a tela anterior
      //abre a tela de usuarios atualizando a tela
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=> HomeView()));
    }
  }

  //atualizar usuario
  void _atualizar() async {
    if(_formKey.currentState!.validate()){
      final usuarioAtualizado = UsuarioModel(
        id: widget.usuario!.id, //id não se altera
        nome: _nomeField.text.trim(), 
        email: _emailField.text.trim()
      );

      try {
        await _controller.create(usuarioAtualizado);
        //mensagem para o usuário
      } catch (e) {
        //mensagem de erro incrivel
      }

      Navigator.pop(context); //volta para a tela anterior
      //abre a tela de usuarios atualizando a tela
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=> HomeView()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        //operador ternario
        widget.usuario == null ? "Novo Usuário" : "Editar Usuário"
      ),),
      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: _formKey, //responsavel por validar o formulario
          child: Column(
            children: [

              TextFormField(
                controller: _nomeField,
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) => value!.isEmpty ? "Informe o Nome" : null,
              ),

              TextFormField(
                controller: _emailField,
                decoration: InputDecoration(labelText: "E-Mail"),
                validator: (value) => value
                !.isEmpty ? "Informe o E-Mail" : null,
              ),
              SizedBox(height: 24,),
              ElevatedButton(
                onPressed: widget.usuario == null ? _criar : _atualizar,
                child: Text(widget.usuario == null ? "Criar" : "Atualizar"))
            ],
          ),
        ),
      ),
    );
  }

}