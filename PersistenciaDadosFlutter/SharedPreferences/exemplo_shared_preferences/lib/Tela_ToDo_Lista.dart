import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaTodoList extends StatefulWidget {
  const TelaTodoList({super.key});

  @override
  _TelaTodoListState createState() => _TelaTodoListState();
}

class _TelaTodoListState extends State<TelaTodoList> {
  //atributos
  String _nome = "";
  bool _darkMode = false;
  List<String> _tarefas = [];
  final TextEditingController _tarefasController = TextEditingController();
  //controlador para novas tarefas

  //lista diferente para cada usuario
  String _chaveLista = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _carregarPreferencias();
  }

  void _carregarPreferencias() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //estabelece conexão

    _nome = prefs.getString("nome") ?? ""; //pega as informações dp nome
    _darkMode = prefs.getBool("darkMode") ?? false; //pega as informações do darkMode
    _chaveLista = "Lista $_nome"; //constroe a chave da lista
    _tarefas = prefs.getStringList(_chaveLista) ?? []; //pega as infomações da lista referente ao usuario especifico

    setState(() {});
  }

  void _salvarTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_tarefasController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("A tarefa está vazia!!")));
    } else {
      _tarefas.add(_tarefasController.text.trim());
      _chaveLista = "Lista $_nome";
      prefs.setStringList(_chaveLista, _tarefas);

      setState(() {
        _tarefasController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Adicionada Com Sucesso")),
        );
          Navigator.pop(context);
      });
    }
  }

  _removerTarefas(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _tarefas.removeAt(index);
    _chaveLista = "Lista $_nome";
    prefs.setStringList(_chaveLista, _tarefas);

    setState(() {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Tarefa removida com sucesso")));
    });
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de tarefas de $_nome"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _tarefas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_tarefas[index]),

              //remover tarefas
              trailing: IconButton(
                onPressed: () => _removerTarefas(index), 
                icon: 
                  Icon(Icons.delete,
                  color: Colors.deepOrange)
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text("Nova tarefa"),
                  content: TextField(
                    controller: _tarefasController,
                    decoration: InputDecoration(hintText: "Digite a tarefa"),
                  ),

                  actions: [
                    TextButton(
                      onPressed: _salvarTarefas,
                      child: Text("Adicionar"),
                    ),
                  ],
                ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }



}