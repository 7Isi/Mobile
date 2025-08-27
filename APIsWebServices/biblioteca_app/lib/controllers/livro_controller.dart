// classe Controller para Usuários

import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {

  //métodos


  //Get Usuários
  Future<List<LivroModel>> fetchAll() async{

    final list = await ApiService.getList("livros");
    //retornar a lista de usuários
    return list.map<LivroModel>((e)=>LivroModel.fromJson(e)).toList();
  }


  //Get Usuário
  Future<LivroModel> fetchOne(String id) async{

    final livro = await ApiService.getOne("livros", id);
    return LivroModel.fromJson(livro);
  }


  //Post Usuário
  Future<LivroModel> create(LivroModel l) async {

    final created = await ApiService.post("livros", l.toJson());
    return LivroModel.fromJson(created);
  }


  //Put Usuário
  Future<LivroModel> update(LivroModel l) async{
    
    final updated = await ApiService.put("livros", l.toJson(), l.id!);
    return LivroModel.fromJson(updated);
  }


  //Delete Usuário
  Future<void> delete(String id) async{
    await ApiService.delete("livros", id);
  }


}