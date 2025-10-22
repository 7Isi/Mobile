import 'dart:io';

import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/models/movie.dart';
import 'package:cine_favorite/views/search_movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _movieController = MovieFirestoreController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Filmes Favoritos"),
        actions: [IconButton(
          onPressed: FirebaseAuth.instance.signOut, 
          icon: Icon(Icons.logout))],
      ),
      //listener ( StreamBuilder) para construir a tela de acordo 
      //com o resultado da lista de favoritos
      body: StreamBuilder<List<Movie>>(
        //buscar a lista de filmes Favoritos no FireStore
        stream: _movieController.getFavoriteMovies(),
        builder: (context, snapshot){
          //se deu erro de conexão
          if(snapshot.hasError){
            return Center(child: Text("Erro ao Carregar a Lista de Favoritos"),);
          }
          //enquanto esta conectadno com o firestore
          if(!snapshot.hasData){//verifica se os dados estão vazios e tranforma em booleana
            return Center(child: CircularProgressIndicator(),);
          }
          //quando a lista de filme esta vazia
          if(snapshot.data!.isEmpty){//o retorno da lista esta vazio
            return Center(child: Text("Nenhum Filme Adicionado aos Favoritos"),);
          }
          //quando existe filme na lista
          final favoriteMovies = snapshot.data!;
          return Expanded( // container que permite o scroll da tela
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //numero de colunas
                crossAxisSpacing: 8, //espacamento entre colunas vertical
                mainAxisSpacing: 8, // espacamento entre linhas horizontal
                childAspectRatio: 0.7),
              itemCount: favoriteMovies.length, //proporção entre a imagem
              itemBuilder: (context, index){
                //criar um obj de movie
                final movie = favoriteMovies[index];
                return Card(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.file(File(movie.posterPath), fit: BoxFit.cover, width: double.infinity),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await _movieController.deleteFavoriteMovie(movie);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(movie.title, textAlign: TextAlign.center),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                starIndex < movie.rating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                          Slider(
                            value: movie.rating,
                            min: 0,
                            max: 5,
                            divisions: 10,
                            label: movie.rating.toString(),
                            onChanged: (newRating) async {
                              setState(() {
                                movie.rating = newRating;
                              });
                              await _movieController.updateMovieRating(movie, newRating);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                );
              })
            );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.push(context, 
          MaterialPageRoute(builder: (context) => SearchMovieView())),
        child: Icon(Icons.search),),
    );

  }
}