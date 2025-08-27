import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivroListView extends StatefulWidget {
  const LivroListView({super.key});

  @override
  State<LivroListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  //atributos
  final _controller = LivroController();
  List<LivroModel> _livros = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  _carregarDados() async{
    setState(() {
      _carregando = true;
    });
    try {
      _livros = await _controller.fetchAll();
    } catch (e) {
      //Tratar Erro      
    }
    setState(() {
      _carregando = false;
    });
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando
      ? Center(child: CircularProgressIndicator(),)
      : Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _livros.length,
          itemBuilder: (context,index){
            final usuario = _livros[index];
            return Card(
              child: ListTile(
                title: Text(usuario.titulo),
                subtitle: Text(usuario.autor),
                //trailing -> icone para deletar o usuário
              ),
            );
          }))
    );
  }
}