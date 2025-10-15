import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main(){
  runApp(MaterialApp(
    home: ImageScreen(),
  ));
}


class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}


class _ImageScreenState extends State<ImageScreen> {
  //instalar a biblioteca image_picker
  //manipulação do arquivo de midia
  File? _image; // obj para armazenar informações de um arquivo do dispositivo
  final ImagePicker _picker = ImagePicker(); //obj controlador da biblioteca image_picker


  // método para captura de imagem pela camera
  void _getImageFromCamera() async{

    //abre a camera e tira uma foto
    // foto é armazenada no pickedFIle 
    //arquivo temporario da biblioteca image_picker
    final XFile? pickedFile = 
      await _picker.pickImage(source: ImageSource.camera);

    //verifica se a imagem não é null
      if(pickedFile != null){
        setState(() {
          //tranfere o caminho da imagem para o arquivo _image
          //passo a imagem de um arquivo temporario para o manipulado de arquivos do aplicativo
          _image = File(pickedFile.path);
        });
      }
  }

  //método para pegar uma imagem da galeria
  void _getImageFromGallery() async{
    //abrir a galeria e pegar uma imagem da galeria
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    //verifica se o arquivo temporario não é nulo
    if(pickedFile != null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    //um espaço para mostrar a imagem selecionada,
    //e dois botões( um para tirar foto e outro para pegar da galeria)
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo de Image Picker"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //operador ternario para colocar a imagem
            _image!=null
            ? Image.file(_image!, height: 300,)
            : Text("Nenhuma imagem encontrada ou selecionada"),

            SizedBox(height: 25,),

            //os dois botões
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text("Tire Foto")),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text("Procure Foto na Galeria"))
          ],
        ),
      ),
    );
  }
}