//criar a classe model para notas

class Nota {
  //atributos

  final int? id; // permite criar objeto com id nulo
  final String titulo;
  final String conteudo;

  //construtores

  Nota({
    this.id,
    required this.titulo,
    required this.conteudo,
  }); //construtpr com os conteudos

  //métodos

  //converter os dados para o banco de dados
  //método MAP => converte um objeto da classe Nota para um Map (para inserir no banco de dados)

  Map<String, dynamic> toMap() {
    return {
      "id": id, 
      "titulo": titulo, 
      "conteudo": conteudo
    };
  }

  //factory -> converte dados do DB para um obj

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map["id"] as int,
      titulo: map["titulo"] as String,
      conteudo: map["conteudo"] as String,
    );
  }

  //toString
  @override
  String toString() {
    return "Nota {id: $id, Título: $titulo, Conteúdo: $conteudo}";
  }
}
