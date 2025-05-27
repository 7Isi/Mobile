import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

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

  Future<Database> _initDatabase() async {
    //pega o local onde esta salvo o BD (path)

    final _dbPath = await getDatabasesPath();
    final path = join(_dbPath, "petshop.db");

    return await openDatabase(path);
  }
}
