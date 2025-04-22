import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FormularioApp()));
}

//classe FormularioApp ()

class FormularioApp extends StatefulWidget {
  const FormularioApp({super.key});

  //linha para chamar o construtor sempre que tiver alteração de estado (SetState)
  @override
  _FormularioAppState createState() => _FormularioAppState();
}

//classe para construir a janela
class _FormularioAppState extends State<FormularioApp> {
  //atributos
  final _formKey = GlobalKey<FormState>();
  String _nome = "";
  String _email = "";
  String _senha = "";
  String _genero = "";
  double _idade = 0;
  bool _aceite = false;

  //métodos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário de Cadastro"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //campo Nome
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                validator:
                    (value) =>
                        value!.isNotEmpty
                            ? null
                            : "Digite seu Nome", //operador ternário
                onSaved: (value) => _nome = value!,
              ),

              SizedBox(height: 25),

              //campo email
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator:
                    (value) =>
                        value!.contains("@")
                            ? null
                            : "Digite um E-Mail válido", //operador ternário
                onSaved: (value) => _email = value!,
              ),

              SizedBox(height: 25),

              //campo senha
              TextFormField(
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
                validator:
                    (value) =>
                        value!.length >= 6
                            ? null
                            : "A senha deve ter no mínino 6 caracters",
                onSaved: (value) => _senha = value!,
              ),

              SizedBox(height: 25),

              //campo selecionar gênero
              DropdownButtonFormField(
                items:
                    ["Feminino", "Masculino", "Outro", "Prefiro Não Dizer"]
                        .map(
                          (String genero) => DropdownMenuItem(
                            value: genero,
                            child: Text(genero),
                          ),
                        )
                        .toList(),
                onChanged: (value) {},
                validator:
                    (value) =>
                        value!.isNotEmpty ? null : "Selecione uma Alternativa",
                onSaved: (value) => _genero = value!,
              ),

              SizedBox(height: 25),

              //Slider Seleção de números
              //selecionar idade
              Text("Selecionar sua Idade"),
              Slider(
                value: _idade,
                min: 0, //valor/idade minina
                max: 99, //valor/idade máxima
                divisions: 99, //nº de divisões - determina o valor individual
                label: _idade.round().toString(),
                onChanged: (value) => setState(() => _idade = value),
              ),

              SizedBox(height: 25),

              //Aceite os Termos
              CheckboxListTile(
                value: _aceite,
                title: Text("~---Aceito os Termos de Uso do App ---~"),
                onChanged: (value) => setState(() => _aceite = value!),
              ),

              SizedBox(height: 25),

              ElevatedButton(onPressed: _enviarCadastro, child: Text("Enviar")),
            ],
          ),
        ),
      ),
    );
  }

  void _enviarCadastro() {
    if (_formKey.currentState!.validate() && _aceite) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Dados do Formulário"),
              content: Column(
                children: [
                  Text("Nome: $_nome"),
                  Text("E-Mail: $_email"),
                  Text("Idade: $_idade"),
                ],
              ),
            ),
      );
    }
  }
}
