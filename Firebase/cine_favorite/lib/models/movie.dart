//classe de modelagem de dados do OBJ movie

class Movie {
  //atributos
  final int id; //ID from tmdb
  final String title; //titulo do filme
  final String posterPath; //caminho para a imagem do filme(poster)
  double rating; //nota que o usuario dara ao filme


  //contrutor
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0,
  });



  //métodos de converção de OBJ para Json, vice e versa

  //toMap (obj => json)
  Map<String,dynamic> toMap() {
    return{
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating
    };
  }

  //fromMap (factory --> OBJ JSON => OBJ)
  factory Movie.fromMap(Map<String,dynamic> map) {
    return Movie(
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble()
    );
  }

}