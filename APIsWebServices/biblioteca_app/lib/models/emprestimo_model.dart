
//classe de modelagem do usuario (atributos iguais as da base de dados)
class EmprestimoModel {
  //atributos
  final String? id; //pode ser nulo inicialmente
  final String usuarioId;
  final String livroId;
  final DateTime dataEmprestimo;
  final DateTime dataDevolucao;
  final bool devolvido;



  //contrutor 
  EmprestimoModel({
    required this.id, 
    required this.usuarioId, 
    required this.livroId, 
    required this.dataEmprestimo, 
    required this.dataDevolucao, 
    required this.devolvido
  });


  //fromJson ==> OBJ
  factory EmprestimoModel.fromJson(Map<String,dynamic> json) => 
  EmprestimoModel(
    id: json["id"].toString(),
    usuarioId: json["usuarioId"].toString(),
    livroId: json["livroId"].toString(),
    dataEmprestimo: json["dataEmprestimo"].toDateTime(),
    dataDevolucao: json["dataDevolucao"].toDateTime(),
    devolvido: json["devolvido"] == true ? true : false
  );


  //toJson OBJ ==> MAP
  Map<String,dynamic> toJson() => {
    "id": id,
    "usuarioId": usuarioId,
    "livroId": livroId,
    "dataEmprestimo": dataEmprestimo,
    "dataDevolucao": dataDevolucao,
    "devolvido": devolvido
  };

}