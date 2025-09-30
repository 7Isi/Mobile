import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/models/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder<List<Movie>>(
        stream: _movieController.getFavoriteMovies(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text("Sua Galeria Esta Vazia"),);
          }
          final movies = snapshot.data!; //monto a lista de filmes
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8), 
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    //criar o cartão na próxima aula
                  ],
                ),
              );
            });
        }),
    );
  }
}