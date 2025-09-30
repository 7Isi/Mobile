//tela inicial que vai listar os Pets do cadastro,

import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/views/cadastro_pets_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // recebe as notificações de mudança e chama o build da tela
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  //buildar a tela

  //atributos
  final _controllerPet = PetController();

  List<Pet> _pets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    _pets = [];

    try {
      _pets = await _controllerPet.readPet();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Exception: $e")));
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus Pets - Cliente")),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: _pets.length,
                  itemBuilder: (context, index) {
                    final pet = _pets[index];
                    return ListTile( // item da ListView
                      title: Text("${pet.nome} - ${pet.raca}"),
                      subtitle: Text("${pet.nomeDono} - ${pet.telefone}"),

                      //onTap: () => , //página de detalhe do PET
                      //onLongPress: () => , //deletar o PET
                    );
                  },
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context)=>CadastroPetScreen())),
        tooltip: "Adicinar Novo Pet",
        child: Icon(Icons.add),
      ),
    );
  }
}
