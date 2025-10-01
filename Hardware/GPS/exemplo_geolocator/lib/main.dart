import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main(){
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //atributos
  String mensagem = "";
  

  //Método para pegar o localização atual
  void getLocartion() async{
    bool servicoDisponivel;
    LocationPermission permissao;

    //verifica se o serviço está disponível
    servicoDisponivel = await Geolocator.isLocationServiceEnabled();
    if(!servicoDisponivel){
      mensagem = "Serviço de Localização indisponivel";
    }
    //solicita permissão para o usuário
    permissao = await Geolocator.checkPermission();
    if(permissao == LocationPermission.denied){
      permissao = await Geolocator.requestPermission();
      if(permissao == LocationPermission.denied){
        mensagem = "Permissão de Localização Negada";
      }
    }

    //após solicitar permissão, ou se a permissão já estiver dado
    //pego a localização do dispositivo
    Position position = await Geolocator.getCurrentPosition();
    mensagem = "Latitude:${position.latitude}, Longitude:${position.longitude}";
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(
              onPressed: () async{getLocartion();},
              child: Text("Obter Localização"))
          ],
        ),
      ),
    );
  }
}