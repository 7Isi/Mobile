import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp (MaterialApp(home: TarefaPage(),));
}


class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}


class _TarefasPageState extends State<TarefaPage> {
  List tarefas = [];

  final TextEditingController _tarefaController = TextEditingController();
  static const String baseUrl = "http://10.109.197.6:3003/terefas";


  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

//método para carregamento de Tarefas da API
  void _carregarTarefas() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      //200 é o código que a conexão foi estabelecida com sucesso
      if(response.statusCode == 200) {
        setState(() {
          //converte as tarefas para o valor
          tarefas = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Erro ao buscar tarefa: $e");
    }
  }


//método para adicionar mais tarefas
  void _adicionarTarefa(String titulo) async {
    final novaTarefa = {"titulo":titulo, "concluida":false};

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type":"application/json"},
        body: json.encode(novaTarefa)
      );

      if(response.statusCode == 201) {
        _tarefaController.clear();
        _carregarTarefas();
      }
    } catch (e) {
      print("Erro ao adicionar tarefa: $e");
    }
  }


//continuação nas próximas aulas
//tem que fazer o remover as tarefas

//fazer o modificar tarefas


}