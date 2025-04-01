//função principal que executa o aplicativo
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: MyApp()));
}

//criar a Janela Principal
class MyApp extends StatelessWidget{
  //criar lista de itens
  List<String> _imagens = [
    "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
  "https://images.unsplash.com/photo-1521747116042-5a810fda9664",
"https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
"https://images.unsplash.com/photo-1518837695005-2083093ee35b",
"https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
"https://images.unsplash.com/photo-1519681393784-d120267933ba",
"https://images.unsplash.com/photo-1531259683007-016a7b628fc3",
"https://images.unsplash.com/photo-1506619216599-9d16d0903dfd",
"https://images.unsplash.com/photo-1494172961521-33799ddd43a5",
"https://images.unsplash.com/photo-1517245386807-bb43f82c33c4",
  ];
  //construtor de Widget
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Galeria de Imagens"),centerTitle: true,),//barra superior do App
      body:Padding(
        padding: EdgeInsets.all(8),
        child:Column(
          children: [
            //Carrossel de Imagens com rolagem automática
            //CarouselSlider - biblioteca Externa
            CarouselSlider(
              options: CarouselOptions(height: 300,autoPlay: true),
              //lista de items
              items: _imagens.map(
                (url)=> Container(
                  margin: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(url,fit: BoxFit.cover,width: 1000),
                  ),
                )
              ).toList()
            ), //fim do carrossel
          //galeria de imagens m uma grade
          Expanded(
            child: GridView.builder(//construir uma grid apartir de uma lista
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //quantidade de imagens por linha
                crossAxisSpacing: 8, //espaçamento entre colunas
                mainAxisSpacing: 8),//espaçamento entre linha
              itemCount: _imagens.length,  
              itemBuilder: (context,index) => 
                GestureDetector(
                  onTap: () => _mostrarImagem(context,_imagens[index]), //Exibe a Imagem em tela cheia ao tocar
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(_imagens[index],fit:BoxFit.cover)),
                )))
          ],
        ))
    );
  }
}

//função para mostrar a imagem em tela cheia
void _mostrarImagem(BuildContext context, String imagem) {
  showDialog(
    context: context, 
    builder: (context)=>Dialog(
      child: Image.network(imagem),
    ));
}