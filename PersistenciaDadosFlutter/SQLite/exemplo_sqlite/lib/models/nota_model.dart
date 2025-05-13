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
      "id" : id,
      "titulo" : titulo,
      "conteudo" : conteudo
    };
  }


  //factory
}
