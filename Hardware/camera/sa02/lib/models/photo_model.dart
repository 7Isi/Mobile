import 'dart:io';

class PhotoModel {
  //atributos
  final File photoPath;
  final String localizacao;
  final String dataHora;

  PhotoModel({
    required this.photoPath, required this.localizacao, required this.dataHora  
  });
}

