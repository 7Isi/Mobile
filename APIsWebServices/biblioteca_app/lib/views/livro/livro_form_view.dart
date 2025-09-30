import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/views/home_view.dart';
import 'package:flutter/material.dart';

class LivroFormView extends StatefulWidget {
  //atributo
  final LivroModel? livro;  //pode ser nulo

  const LivroFormView({super.key, this.livro}); //Livro não é obrigatorio no construtor

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {

  //atributos
  final _formKey = GlobalKey<FormState>();//validação do formulário
  final _controller = LivroController();//comunicação entre view e o model
  final _tituloField = TextEditingController(); //controlar o campo nome
  final _autorField = TextEditingController();//controllar o campo email

  @override
  void initState() {
    super.initState();
    if(widget.livro != null){
      _tituloField.text = widget.livro!.titulo; 
      _autorField.text = widget.livro!.autor;
    }
  }

  //criar usuario
  void _criar() async{
    if(_formKey.currentState!.validate()){
      final livroNovo = LivroModel(
        id: DateTime.now().millisecond.toString(),
        titulo: _tituloField.text.trim(), 
        autor: _autorField.text.trim(),
        disponivel: true
      );

      try {
        await _controller.create(livroNovo);
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
      final livroAtualizado = LivroModel(
        id: widget.livro!.id, //id não se altera
        titulo: _tituloField.text.trim(),
        disponivel: widget.livro!.disponivel
      );

      try {
        await _controller.create(livroAtualizado);
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
        widget.livro == null ? "Novo Livro" : "Editar Livro"
      ),),
      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: _formKey, //responsavel por validar o formulario
          child: Column(
            children: [

              TextFormField(
                controller: _tituloField,
                decoration: InputDecoration(labelText: "Titulo"),
                validator: (value) => value!.isEmpty ? "Informe o Titulo" : null,
              ),

              TextFormField(
                controller: _autorField,
                decoration: InputDecoration(labelText: "Autor"),
                validator: (value) => value
                !.isEmpty ? "Informe o Autor" : null,
              ),

              SizedBox(height: 24,),
              ElevatedButton(
                onPressed: widget.livro == null ? _criar : _atualizar,
                child: Text(widget.livro == null ? "Criar" : "Atualizar"))
            ],
          ),
        ),
      ),
    );
  }

}