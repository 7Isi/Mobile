//criação de um app To Do Lista com StateFullWidget

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ToDoListApp()));
}

//1ª classe - chamar mudanças de estado
class ToDoListApp extends StatefulWidget {
  @override
  _ToDoListAppState createState() => _ToDoListAppState(); //obj para pegar o valor do texto
} //chama as mudanças de estado

//2ª classe - construção do build
class _ToDoListAppState extends State<ToDoListApp> {
  //Atributos
  final TextEditingController _tarefaController = TextEditingController();
  List<Map<String, dynamic>> _tarefa = [];

  //Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController, //obj para pegar o valor do texto
              decoration: InputDecoration(labelText: "~--Digite uma Tarefa--~"),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: Text("Adicionar Tarefa"),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: _tarefa.length,
                itemBuilder:
                    (context, index) => ListTile(
                      title: Text(
                        _tarefa[index]["titulo"],
                        style: TextStyle(
                          //condição para decoração do texto
                          decoration:
                              _tarefa[index]["concluida"]
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ),

                      leading: Checkbox(
                        value: _tarefa[index]["concluida"],
                        onChanged:
                            (bool? valor) => setState(() {
                              _tarefa[index]["concluida"] = valor!;
                            }),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _adicionarTarefa() {
    if (_tarefaController.text.trim().isNotEmpty) {
      setState(() {
        //para cada tarefa dd = titulo  concluida
        _tarefa.add({"titulo": _tarefaController.text, "concluida": false});

        _tarefaController.clear();
      });
    }
  }
}
