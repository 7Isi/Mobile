//converter Json <--> Dart


import 'dart:convert';



void main() {
  String jsonString = '''{
                      "id":"abc1234",
                      "nome":"Arthur",
                      "idade":30,
                      "login":"UserArthur",
                      "senha":"g4t05",
                      "ativo":true
                    }''';


    //decode jsonString
    Map<String,dynamic> usuario = json.decode(jsonString);

    print(usuario["nome"]); //Arthur
    print(usuario["login"]); //UserArthur


    //modificar a senha do usuario para uma com 6 digitos
  usuario["senha"] = "g4t05s";


    //gravar no Json
  jsonString = json.encode(usuario);
  print(jsonString);


}