import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/views/home_screen.dart';

class CadastroPetScreen extends StatefulWidget {
  const CadastroPetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  //atributos
  final _formKey = GlobalKey<FormState>();
  final _controllerPet = PetController();

  //atributos do obj
  late String _nome; //permite que a variavel sejá null inicialemnte
  late String _raca;
  late String _nomeDono;
  late String _telefone;

  //método para cadastrar o pet (salvar no bd e voltar para o homescreen)
  _salvarPet() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newPet = Pet(
        nome: _nome,
        raca: _raca,
        nomeDono: _nomeDono,
        telefone: _telefone,
      );
      await _controllerPet.createPet(newPet);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Pet"),),
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [

            TextFormField(
              decoration: InputDecoration(labelText: "Nome do Pet"),
              validator: (value) => value!.isEmpty ? "Campo não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),
            
            TextFormField(
              decoration: InputDecoration(labelText: "Raça do Pet"),
              validator: (value) => value!.isEmpty ? "Campo não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),
            
            TextFormField(
              decoration: InputDecoration(labelText: "Nome do Dono"),
              validator: (value) => value!.isEmpty ? "Campo não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),

            TextFormField(
              decoration: InputDecoration(labelText: "Telefone"),
              validator: (value) => value!.isEmpty ? "Campo não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),

            ElevatedButton(onPressed: _salvarPet, child: Text("Cadastrar"))

          ],
        )),
      ),
    );
  }
}
