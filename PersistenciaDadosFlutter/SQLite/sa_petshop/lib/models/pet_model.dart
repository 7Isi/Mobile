class Pet {
  //atributos -> id, nome, raça, nomeDono, telefoneDono

  final int? id; //pode ser nula em algun momento
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefone;

  //métodos de acesso publico (getters and setters)
  //caso algum atributo fosse privado
  // getId() {
  //   return id;
  // }

  // setId(int id) {
  //   this._id = id;
  // }

  //constructor

  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefone,
  });



  //métodos de converção OBJ <--> BD
  //toMap : obj -> entidade do BD

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "raca": raca,
      "nome_dono": nomeDono,
      "telefone": telefone,
    };
  }


  //fromMap BD -> obj
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map["id"] as int,
      nome: map["nome"] as String,
      raca: map["raca"] as String,
      nomeDono: map["nome_dono"] as String,
      telefone: map["telefone"] as String,
    );
  }

  @override
  String toString() {
    return "Pet{id: $id, nome: $nome, raca: $raca, dono: $nomeDono, telefone: $telefone}";
  }
}
