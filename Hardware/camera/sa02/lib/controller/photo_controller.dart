import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/photo_model.dart';

class PhotoController {
  // método para pegar a localização,
  // a partir da geolocator, pegar a data e hora
  //pegar a imagem da camera

  //método retorna um obj de PhotoModel
  Future<PhotoModel> photoWithLocation() async{
    final picker = ImagePicker();
    File? photoPath;
    String location = "";

    // solicitar a geolocalização
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      throw Exception("Serviço de GeoLocalização não Habilitado");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission ==  LocationPermission.denied){
        throw Exception("Serviço de Localização Desabilitado");
      }
    }
    // conectar com a API de Localizção
    Position position = await Geolocator.getCurrentPosition();
    //conexão com api
    final result = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?appid=CHAVE_API&lat=${position.latitude}&lon=${position.longitude}")
    );
    //verifico o resultado
    if(result.statusCode == 200){
      //convert em Map<String,dynamic>
      Map<String,dynamic> data = jsonDecode(result.body);
      location = data["name"]; // aramazena o nome da cidade
    }else{
      throw Exception("Erro ao Comunicar com API");
    }
    
    // Tirar a Photo
    final XFile? photoTirada = await picker.pickImage(source: ImageSource.camera);
    if(photoTirada != null){
      photoPath = File(photoTirada.path);
    }

    //Criar o OBJ
    final PhotoModel photo = PhotoModel(
      photoPath: photoPath!, 
      localizacao: location, 
      dataHora: DateTime.now().toIso8601String());

    return photo;
  }
}