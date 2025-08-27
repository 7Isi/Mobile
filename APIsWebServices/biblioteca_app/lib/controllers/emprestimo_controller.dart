// classe Controller para Usuários

import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {

  //métodos


  //Get Usuários
  Future<List<EmprestimoModel>> fetchAll() async{

    final list = await ApiService.getList("emprestimo");
    //retornar a lista de usuários
    return list.map<EmprestimoModel>((e)=>EmprestimoModel.fromJson(e)).toList();
  }


  //Get Usuário
  Future<EmprestimoModel> fetchOne(String id) async{

    final emprestimo = await ApiService.getOne("emprestimo", id);
    return EmprestimoModel.fromJson(emprestimo);
  }


  //Post Usuário
  Future<EmprestimoModel> create(EmprestimoModel e) async {

    final created = await ApiService.post("emprestimo", e.toJson());
    return EmprestimoModel.fromJson(created);
  }


  //Put Usuário
  Future<EmprestimoModel> update(EmprestimoModel e) async{
    
    final updated = await ApiService.put("emprestimo", e.toJson(), e.id!);
    return EmprestimoModel.fromJson(updated);
  }


  //Delete Usuário
  Future<void> delete(String id) async{
    await ApiService.delete("emprestimo", id);
  }


}