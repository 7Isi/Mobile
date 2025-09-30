import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:flutter/material.dart';

class EmprestimoListView extends StatefulWidget {
  const EmprestimoListView({super.key});

  @override
  State<EmprestimoListView> createState() => _EmprestimoListViewState();
}

class _EmprestimoListViewState extends State<EmprestimoListView> {
  //atributos
  final _controller = EmprestimoController();
  List<EmprestimoModel> _emprestimos = [];
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
      _emprestimos = await _controller.fetchAll();
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
          itemCount: emprestimos.length,
          itemBuilder: (context,index){
            final emprestimos = emprestimos[index];
            return Card(
              child: ListTile(
                title: Text(emprestimos.dataEmprestimo),
                subtitle: Text(emprestimos.dataDevolucao),
                //trailing -> icone para deletar o usuário
              ),
            );
          }))
    );
  }
}