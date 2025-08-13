import 'dart:convert'; //biblioteca interna do dart (não precisa instalar no pubspec)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}


//classe que chama a Mudança de estado
class MyApp extends StatefulWidget { //permite mudança de estado

//construtor
  const MyApp({super.key});


//método de mudança de estado
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}


//classe que montar(build) os componentes da tela
class _MyAppState extends State<MyApp> { 

//atributos de classe
bool _temaEscuro = false; //vai controlar a mudança de tema
late TextEditingController _nomeController; //vai controlar a inserção de textp dentro do TextFormField


//métodos
//precisa carregar as informações no começo da aplicação
@override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _carregarPreferencias();
  }

  void _carregarPreferencias() async {
    //estabelece conexão com o SharedPreferences(cache)
    final prefs = await SharedPreferences.getInstance();

    //buscas um texto em formato Json com as informações do usuário
    // { "temaEscuro": true, "nome": "Nome do Usuário", "idade": 25 }
    String? jsonConfig = prefs.getString("config");
    if(jsonConfig != null) {
      print(jsonConfig);

      Map<String,dynamic> config = json.decode(jsonConfig);
      setState(() { //chama a mudança de tela
        _temaEscuro = config["temaEscuro"] ?? false; //operador de coalecencia
        _nomeController.text = config["nome"] ?? "";
      });
    } //final do if

  } //final do método


  void _salvarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    
    Map<String, dynamic> config = {
      "temaEscuro": _temaEscuro,
      "nome": _nomeController.text.trim()
    };

    String jsonConfig = json.encode(config);
    prefs.setString("config", jsonConfig);

    //snakcBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Preferências Salvas!!"))
    );
  }


@override
  Widget build(BuildContext context) { //precisa do buils para montar a tela
    return MaterialApp(

      //operador ternario
      theme: _temaEscuro ? ThemeData.dark() : ThemeData.light(),

      home: Scaffold(
        appBar: AppBar(title: Text("Preferências do Usuário"),),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SwitchListTile(
                title: Text("Tema Escuro"),
                value: _temaEscuro,
                onChanged: (value) {
                  setState(() {
                    _temaEscuro = value;
                  });
                }
              ),

              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome do Usuário"),
              ),

              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _salvarPreferencias,
                child: Text("Salvar preferências")),

              SizedBox(height: 20,),
              Divider(),

              Text("Configurações Atuais", style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),

              Text("Tema: ${_temaEscuro ? "Escuro" : "Claro"}"),
              Text("Usuário: ${_nomeController.text}")
            ],
          ),
        ),
      ),
    );
  }

}