import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sa02/models/photo_model.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  //lista com as photos
  List<PhotoModel> photos = [];

  //método apra tirar photo
  void takePicture() async{
    //chama o controlador para tirar photo
    setState(() {
      //adiciona a photo na lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body:  //gridView,
        GridView.builder(
          itemCount: photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            final photo = photos[index];

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Detalhes da Foto"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.file(photo.photoPath),
                        SizedBox(height: 8),
                        Text("Localização: ${photo.localizacao}"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Fechar"),
                      ),
                    ],
                  ),
                );

                //mostra photo e as informações
              },
              child: Image.file(
                photo.photoPath, 
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }
}