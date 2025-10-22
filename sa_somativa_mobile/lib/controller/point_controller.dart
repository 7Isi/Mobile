import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_somativa_mobile/model/point_model.dart';

class PointController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  final StreamController<PointLocation> _localizacaoController = StreamController.broadcast();
  Stream<PointLocation> get localizacaoStream => _localizacaoController.stream;

  Future<void> iniciarLocalizacao() async {
    try {
      final ponto = await pegarPontoLocalizacao();
      _localizacaoController.add(ponto);
    } catch (e) {
      _localizacaoController.addError(e);
    }
  }


  Future<PointLocation> pegarPontoLocalizacao() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem acesso ao GPS!!");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão GPS Negada");
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    String dataHora = _formatar.format(DateTime.now());

    PointLocation posicaoAtual = PointLocation(
      latitude: position.latitude,
      longitude: position.longitude,
      dataHora: dataHora,
    );

    return posicaoAtual;
  }


  void dispose() {
    _localizacaoController.close();
  }
}
