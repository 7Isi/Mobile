import 'dart:convert';
import 'package:http/http.dart' as http;

//classe que vai auxiliar as conexões com o banco de dados

class ApiService {
  //criar métodos de classe e não métodos de OBJ
  // permite uma maior segurança na solicitação de requisições http
  //static --> métodos e atributos de classe

  static const String _baseUrl = "http://10.109.197.9:3003";


  //método da classe

  //get --> pega a lista de recurso
  static Future<List<dynamic>> getList(String path) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path"));

    //verificar a reposta
    if(res.statusCode == 200) return json.decode(res.body);
    //se não der certo
    throw Exception("Falha ao carregar lista de $path");
  }


  //get --> pega um unico recurso
  static Future<Map<String,dynamic>> getOne(String path, String id) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));

    if(res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Carregar Recurso de $path/$id");
  }


  //post --> adicionar recursos no bd
  static Future<Map<String,dynamic>> post(String path, Map<String,dynamic> body) async{
    final res = await http.post(
      Uri.parse("$_baseUrl/$path"),
      headers: {"Content-Type": "aplication/json"},
      body: json.encode(body)
    );

    if(res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao Adicionar Recurso em $path");
  }
  

  //put --> altera recurso do bd
  static Future<Map<String,dynamic>> put(String path, Map<String,dynamic> body, String id) async{
    final res = await http.put(
      Uri.parse("$_baseUrl/$path/$id"),
      headers: {"Content-Type": "aplication/json"},
      body: json.encode(body)
    );

    if(res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Alterar Recurso em $path/$id");
  }


  //delete --> remove o recurso do bd
  static Future<void> delete(String path, String id) async{
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));

    if(res.statusCode != 200) throw Exception("Falha ao Deletar Recurso $path/$id");
  }
}