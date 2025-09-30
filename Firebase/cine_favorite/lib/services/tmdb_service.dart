//meu servicço de conexão com APi TMDB
import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbService {
  //colocar os dados da API
  static const String _apiKey = "1fa5c2d59029fd1c438cc35713720604";
  static const String _baseURL = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";
  //static são atributos da classe e não do OBJ


  //métodos static, ou seja, métodos da classe, portanto, não preciso instanciar um OBJ para executar o método

  //buscar filmes na API
  static Future <List<Map<String,dynamic>>> searchMovie(String movie) async{
    //converter a String em URL
    final apiURI = Uri.parse("$_baseURL/search/movie?api_key=$_apiKey&query=$movie&language=$_idioma");

    //http.get (request http --> get)
    final response = await http.get(apiURI);

    //verificar a resposta
    if(response.statusCode == 200) {
      //converte o resultado Json em Dart
      final data = json.decode(response.body);
      //transformar data(String) em List
      return List<Map<String,dynamic>>.from(data["results"]);
    }
    else{
      //caso contrario criar uma exception
      throw Exception("Falha ao carregar filmes da API");
    }
  }


  //método para busca de filme pelo ID
  
}