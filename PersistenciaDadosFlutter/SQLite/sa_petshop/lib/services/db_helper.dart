import 'package:path/path.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _database;

  //transformar essa classe em singleton
  //não permite instanciar outro obj enquanto um obj estiver ativ

  static final DbHelper _instance = DbHelper._internal();

  //construir o singleton
  DbHelper._internal();
  factory DbHelper() {
    return _instance;
  }

  //conexões com banco de dados
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  //método para criar tabela
  Future<Database> _initDatabase() async {
    //pega o local onde esta salvo o BD (path)

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "petshop.db");

    return await openDatabase(
      path,

      onCreate: (db, version) async {
        await db.execute("""CREATE TABLE IF NOT EXISTS pets (
        id INTERGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        raca TEXT NOT NULL,
        nome_dono TEXT NOT NULL,
        telefone TEXT NOT NULL)""");
        print("Tabela Pets criada com sucesso");

        await db.execute("""CREATE TABLE IF NOT EXISTS consultas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pet_id INTEGER NOT NULL,
        data_hora TEXT NOT NULL,
        tipo_servico TEXT NOT NULL,
        observacao TEXT NOT NULL,
        FOREING KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE)""");
        print("Tabela Consulta criada com sucesso");
      },
      version: 1,
    );

    //criado a parte do db
  }

  //método CRUD do BD
  //PETS

  //inserir(CREATE)
  Future<int> insertPet(Pet pet) async {
    //conectar com BD
    final db = await database; //verifica a conezão com o banco de dados

    return db.insert("pets", pet.toMap()); // inseri o dado no banco de dados
  }

  //get - read
  Future<List<Pet>> getPets() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("pets");

    return maps.map((e) => Pet.fromMap(e)).toList();
  }

  //get - readById
  Future<Pet?> getPetById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      "pets",
      where: "id=?",
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    } else {
      return Pet.fromMap(maps.first);
    }
  }

  //delet - deletar
  Future<int> deletePet(int id) async {
    final db = await database;

    return db.delete("pets", where: "id=?", whereArgs: [id]);
  }

  //CRUD para consultas

  //create - insert
  Future<int> insertConsulta(Consulta consulta) async {
    final db = await database;

    return await db.insert(
      "consultas",
      consulta.toMap(),
    ); // insere a consulta no db
  }

  //read - getConsultaByPet
  Future<List<Consulta>> getConsultaByPet(int petId) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      "consultas",
      where: "pet_id = ?",
      whereArgs: [petId],
    );
    return maps.map((e) => Consulta.fromMap(e)).toList(); //laço de repetição
  }

  //delete - delete
  Future<int> deleteConsulta(int id) async {
    final db = await database;

    return await db.delete(
      "consultas", 
      where: "id=?", 
      whereArgs: [id]
    );
  }
}
