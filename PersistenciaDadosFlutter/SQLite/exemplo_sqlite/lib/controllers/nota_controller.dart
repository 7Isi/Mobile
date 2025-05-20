import 'package:exemplo_sqlite/models/nota_model.dart';
import 'package:exemplo_sqlite/services/nota_db_helper.dart';

class NotaController {
  NotaDBHelper _dbHelper = NotaDBHelper();

  //criar os controllers
  Future<int> createNota(Nota nota) async {
    return _dbHelper.insertNota(nota);
  }

  Future<List<Nota>> readNotas() async {
    return _dbHelper.getNotas();
  }

  Future<int> updateNota(Nota nota) async {
    return _dbHelper.updateNota(nota);
  }

  Future<int> deleterNota(int id) async {
    return _dbHelper.deleteNota(id);
  }

}
