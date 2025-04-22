import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  double _idade = 18;
  bool _aceiteTermos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCampo("Nome", _nomeController),
            const SizedBox(height: 16),
            _buildCampo("Email", _emailController),
            const SizedBox(height: 16),
            Text("Idade: ${_idade.toInt()}"),
            Slider(
              value: _idade,
              min: 0,
              max: 99,
              divisions: 99,
              label: _idade.round().toString(),
              onChanged: (val) => setState(() => _idade = val),
              activeColor: const Color(0xFF42A5F5),
            ),
            CheckboxListTile(
              value: _aceiteTermos,
              title: const Text("Aceito os Termos"),
              onChanged: (val) => setState(() => _aceiteTermos = val!),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _enviarCadastro,
              child: const Text("Cadastrar"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCampo(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  void _enviarCadastro() {
    if (_nomeController.text.isEmpty || _emailController.text.isEmpty) {
      _mostrarMensagem("Preencha todos os campos.");
      return;
    }
    if (_idade < 18) {
      _mostrarMensagem("Idade mínima: 18 anos.");
      return;
    }
    if (!_aceiteTermos) {
      _mostrarMensagem("Você precisa aceitar os termos.");
      return;
    }

    Navigator.pushNamed(context, "/tarefas");
  }

  void _mostrarMensagem(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
