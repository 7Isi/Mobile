import 'package:flutter/material.dart';

class TelaTarefas extends StatefulWidget {
  const TelaTarefas({super.key});

  @override
  _TelaTarefasState createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas> {
  final TextEditingController _tarefaController = TextEditingController();
  final List<Map<String, dynamic>> _tarefas = [];

  @override
  Widget build(BuildContext context) {
    final concluidas = _tarefas.where((t) => t["concluida"]).toList();
    final pendentes = _tarefas.where((t) => !t["concluida"]).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text('Tarefas', style: TextStyle(color: Colors.white)),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('lib/views/assets/logo.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: const InputDecoration(
                labelText: "Digite uma nova tarefa",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: const Text("Adicionar"),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBBDEFB),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    const Text("✅ CONCLUÍDAS", style: TextStyle(fontWeight: FontWeight.bold)),
                    ...concluidas.map((t) => _buildItem(t, true)),
                    const SizedBox(height: 12),
                    const Text("🕒 PENDENTES", style: TextStyle(fontWeight: FontWeight.bold)),
                    ...pendentes.map((t) => _buildItem(t, false)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 232, 250, 255)),
              onPressed: _removerTarefasConcluidas,
              child: const Text("Remover Concluídas"),
            )
          ],
        ),
      ),
            bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1565C0),
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.refresh), label: 'Recarregar'),
        ],
        onTap: (index) {
          if (index == 1) Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> tarefa, bool concluida) {
    return Card(
      child: ListTile(
        leading: Icon(concluida ? Icons.check : Icons.pending, color: Colors.green),
        title: Text(
          tarefa["titulo"],
          style: TextStyle(decoration: concluida ? TextDecoration.lineThrough : null),
        ),
        onTap: () => _toggleTarefa(tarefa),
      ),
    );
  }

  void _adicionarTarefa() {
    if (_tarefaController.text.trim().isNotEmpty) {
      setState(() {
        _tarefas.add({"titulo": _tarefaController.text.trim(), "concluida": false});
        _tarefaController.clear();
      });
    }
  }

  void _toggleTarefa(Map<String, dynamic> tarefa) {
    setState(() {
      tarefa["concluida"] = !tarefa["concluida"];
    });
  }

  void _removerTarefasConcluidas() {
    setState(() {
      _tarefas.removeWhere((t) => t["concluida"]);
    });
  }

}
