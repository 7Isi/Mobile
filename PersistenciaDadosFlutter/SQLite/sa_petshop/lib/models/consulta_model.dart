import 'package:intl/intl.dart';

class Consulta {
  //atributos --> id, petID, dataHora, tipoSerivco, observacao

  final int? id;
  final int petId;
  final DateTime dataHora;
  final String tipoServico;
  final String observacao;

  //contrutor em formato rapido

  Consulta({
    this.id,
    required this.petId,
    required this.dataHora,
    required this.tipoServico,
    required this.observacao,
  });



  //método de Converção
  //toMap Obj --> BD
  Map<String, dynamic> toMap() => {
    "id": id,
    "pet_id": petId,
    "data_hora": dataHora.toIso8601String(),
    "tipo_servico": tipoServico,
    "observacao": observacao,
  };


  //fromMap() : BD --> obj
  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      id: map["id"] as int,
      petId: map["pet_id"] as int,
      dataHora: DateTime.parse(map["data_hora"] as String),
      tipoServico: map["tipo_servico"] as String,
      observacao: map["observacao"] as String,
    );
  }



  //método para converter dataHora em Formato Local("dd/MM/yyyy  HH:mm")

  String get dataHoraLocal {
    final local = DateFormat("dd/MM/yyyy HH:mm");
    return local.format(dataHora);
  }


  @override
  String toString() {
    return "Consulta: {id $id, petId: $petId, dataHora: $dataHora, serviço: $tipoServico, observação: $observacao}";
  }
}
