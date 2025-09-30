//tela de detalhe do pet

import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/consulta_controller.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';

class DetalhePetScreen extends StatefulWidget {
  //atributos
  final int petId; //receber o Id do Pet

  //construtor para pegar o id do pet
  const DetalhePetScreen({super.key, required this.petId});

  @override
  State<StatefulWidget> createState() {
    return _DetalhePetScreenState();
  }
}

class _DetalhePetScreenState extends State<DetalhePetScreen> {
  //atributos
  final _controllerPet = PetController();
  final _controllerConsulta = ConsultaController();

  bool _isLoading = true;

  Pet? _pet;
  List<Consulta> _consultas = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
    });

    _consultas = [];

    try {
      _pet = await _controllerPet.readPetById(widget.petId);
      _consultas = await _controllerConsulta.readConsultaByPet(widget.petId);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Exception $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes do pet")),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _pet ==
                  null //verifica se o pet foi encontrado
              ? Center(child: Text("Erro ao carregar o pet. Verifique o ID"))
              : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nome: ${_pet!.nome}", style: TextStyle(fontSize: 20)),
                    Text("Raça: ${_pet!.raca}"),
                    Text("Raça: ${_pet!.nomeDono}"),
                    Text("Raça: ${_pet!.telefone}"),
                    Divider(), //linha ou divisão (igual um hr do html)

                    Text("Consultas"), //style
                    //operador ternario para consultas
                    _consultas.isEmpty
                        ? Center(
                          child: Text("Não possui consultas cadastradas!!"),
                        )
                        : Expanded(
                          child: ListView.builder(
                            itemCount: _consultas.length,
                            itemBuilder: (context, index) {
                              final consulta =
                                  _consultas[index]; //criando um vetor a partir do vetor de objs
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  title: Text(consulta.tipoServico),
                                  subtitle: Text(consulta.dataHoraLocal),
                                ),
                              );
                            },
                          ),
                        ),
                  ],
                ),
              ),
        //floatingActionButton; , navegar para o formulario de criação de consulta
    );
  }
}
