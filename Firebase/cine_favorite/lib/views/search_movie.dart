//Tela para Procurar Filmes na API, permite adicionar filmes aos Favoritos

import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/services/tmdb_service.dart';
import 'package:flutter/material.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  //atributos
  final _favMovieController = MovieFirestoreController();
  final _searchField = TextEditingController();

  List<Map<String,dynamic>> _movies = [];

  bool _isLoading = false;


  // método para listar filmes a partir da procura
  void _searchMovies() async{
    //pegar o texto do textField
    final termo = _searchField.text.trim();
    if(termo.isEmpty) return; //para o método

    setState(() {
      _isLoading = true;
    });
    //busca do termo na API
    try {
      final result = await TmdbService.searchMovie(termo);
      _movies = result;
    } catch (e) {
      _movies=[];
      print(e);
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar Filmes"),),
      body: Padding(
        padding: EdgeInsets.all(8), 
        child: Column(
          children: [
            TextField(
              controller: _searchField,
              decoration: InputDecoration(
                labelText: "Nome do Filme",
                border: OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: _searchMovies, 
                  icon: Icon(Icons.search))
              ),
            ),
            SizedBox(height: 10,),
            //listar os filme encontrados na API
            //operador Ternário
            _isLoading ? Center(child: CircularProgressIndicator(),) 
            : _movies.isEmpty ? Center(child: Text("Nenhum Filme Encontrado"),)
            : Expanded(child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index){
                final movie = _movies[index];
                return ListTile(
                  leading: 
                    Image.network("https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
                      height: 50,),
                  title: Text(movie["title"]),
                  subtitle: Text(movie["release_date"]),
                  trailing: IconButton(
                    onPressed: () async{
                      _favMovieController.addFavoriteMovie(movie);
                      //mensagem
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${movie["title"]} adicionado com sucesso!"))
                      );
                      Navigator.pop(context); //fecha a tela de procura
                    }, 
                    icon: Icon(Icons.add)),
                );
              }))
          ],
        )
      ),
    );
  }
}