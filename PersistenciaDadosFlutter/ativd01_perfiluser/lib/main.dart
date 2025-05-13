import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  //onde roda minha aplicação
  runApp(
    MaterialApp(
      //Widget Principal (Elementos Visuais) - raiz do meu aplicativo
      //home:
      home: PerfilPage(),
      //configurações de rota
      //route:{}, // mais de uma página
      //configuração do theme
    ),
  );
}

//minha classe para o perfil page

class PerfilPage extends StatefulWidget {
  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  //atributos

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  String? _corSelecionada;
  Color _corFundo = Colors.white;

  String? _nomeSalvo;
  String? _idadeSalva;
  String? _corSalva;

  final Map<String, Color> coresDisponiveis = {
    "Azul" : Colors.blue,
    "Verde" : Colors.green,
    "Vermelho" : Colors.red,
    "Amarelo" : Colors.yellow,
    "Cinza" : Colors.grey,
  };


  @override
  void initState() {

    super.initState();
    _carregarDados();
  }

  _carregarDados() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString("nome");
      _idadeSalva = prefs.getString("idade");
      _corSalva = prefs.getString("cor");

      if(_corSalva != null && coresDisponiveis.containsKey(_corSalva!)) {
        _corFundo = coresDisponiveis[_corSalva!]!;
        _corSelecionada = _corSalva;
      }
    });
  }


    _salvarDados() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("nome", _nomeController.text.trim());
      await prefs.setString("idade", _idadeController.text.trim());
      await prefs.setString("cor", _corSelecionada ?? "Azul");


    setState(() {
      _nomeSalvo = _nomeController.text.trim();
      _idadeSalva = _idadeController.text.trim();
      _corSalva = _corSelecionada ?? "Azul";
      _corFundo = coresDisponiveis[_corSalva!]!;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(
        title: Text("Meu Perfil Persistente"),
        backgroundColor: const Color.fromARGB(221, 44, 44, 44),
      ),

      body: Padding(padding: EdgeInsets.all(16),
      child: ListView(
        children: [

          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: "Nome"),
          ),

          TextField(
            controller: _idadeController,
            decoration: InputDecoration(labelText: "Idade"),
            keyboardType: TextInputType.numberWithOptions(),
          ),

          SizedBox(height: 15,),
          DropdownButtonFormField(
            value: _corSelecionada,
            decoration: InputDecoration(labelText: "Cor Favorita"),
            items: coresDisponiveis.keys.map((cor) {
              return DropdownMenuItem(
                value: cor,
                child: Text(cor));
              }
            ).toList(),
            onChanged: (valor){
              setState(() {
                _corSelecionada = valor;
              });
            }),

            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _salvarDados, child: Text("Salvar Dados")),

          SizedBox(height: 16,),
          Divider(),
          Text("Dados Salvos: "),

          if(_nomeSalvo != null) 
            Text("Nome: $_nomeSalvo"),
            
          if(_nomeSalvo != null) 
            Text("Idade: $_idadeSalva"),

          if(_nomeSalvo != null) 
            Text("Cor: $_corSalva"),

        ],
      ),
      ),
    );
  }

  
}
