// uma classe para criar as conexões com o banco de dados
//innstalar as dependencias do banco de dados - pubspec

import 'package:exemplo_sqlite/models/nota_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotaDBHelper {
  static Database? _database; // pode ser nula - inicialmente

  static const String DB_NAME = "nota.db";
  static const String TABLE_NAME = "nota";

  static const String CREATE_SQL = """
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT NOT NULL,
      conteudo TEXT NOT NULL
    )""";

  //criar conexão com o db
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DB_NAME);

    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(CREATE_SQL);
      },
      version: 1,
    );
  }

  //criar o crud para o banco de dados
  //create
  Future<int> insertNota(Nota nota) async {
    final db = await database;

    //executo o comando para inserir
    return await db.insert(TABLE_NAME, nota.toMap());
  }

  //read
  Future<List<Nota>> getNotas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    return maps.map((e) => Nota.fromMap(e)).toList();
  }

  //update
  Future<int> updateNota(Nota nota) async {
    if (nota.id == null) {
      //não é possível atualizar a nota
      throw Exception("Impossível Atualizar a Nota sem ID...");
    } else {
      final db = await database;
      return await db.update(
        TABLE_NAME,
        nota.toMap(),
        where: "id: ?",
        whereArgs: [nota.id],
      );
    }
  }

  //delete
  Future<int> deleteNota(int id) async {
    final db = await database;
    return await db.delete(TABLE_NAME, 
    where: "id: ?", 
    whereArgs: [id]
    );
  }

}
