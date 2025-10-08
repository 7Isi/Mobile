import 'package:exemplo_geolocator/clima_service.dart';
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
  void getLocation() async{
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

  //método para buscar a cidade e a temperatura
  void getCityWeather() async{
    //verificar se a serviço está habilitado
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      mensagem = "Serviço de GPS não habilitado";
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      //solicitação de permição
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        mensagem = "Serviço de GPS indisponível";
        return;
      }
    }
    //se serviço for habilitado
    Position position = await Geolocator.getCurrentPosition();
    //chamar a api de clima
    try {
      final cidade = await ClimaService.getCityWeatherByPosition(position);
      mensagem = "${cidade["name"]}: ${cidade["main"]["temp"] -273} °C";
    } catch (e) {
      mensagem = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(onPressed: () async{getLocation();},
             child: Text("Obter Localização")),
            ElevatedButton(onPressed: () async{
              setState(() {
                getCityWeather();
              });
            }, child: Text("Obter Clima"))
          ],
        ),
      ),
    );
  }
}