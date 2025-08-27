
//classe de modelagem do usuario (atributos iguais as da base de dados)
class LivroModel {
  //atributos
  final String? id; //pode ser nulo inicialmente
  final String titulo;
  final String autor;
  final bool disponivel;


  //contrutor 
  LivroModel({
    this.id, required this.titulo, required this.autor, required this.disponivel
  });


  //fromJson Map ==> OBJ
  factory LivroModel.fromJson(Map<String,dynamic> json) => 
  LivroModel(
    id: json["id"].toString(),
    titulo: json["titulo"].toString(),
    autor: json["autor"].toString(),
    disponivel: json["disponivel"] ==1 ? true : false
  );


  //toJson OBJ ==> MAP
  Map<String,dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "autor": autor,
    "disponivel": disponivel
  };

}