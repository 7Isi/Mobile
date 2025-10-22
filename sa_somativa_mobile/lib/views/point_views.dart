import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sa_somativa_mobile/model/point_model.dart';
import 'package:sa_somativa_mobile/controller/point_controller.dart';

class PointView extends StatefulWidget {
  const PointView({super.key});

  @override
  State<PointView> createState() => _PointViewState();
}

class _PointViewState extends State<PointView> {
  final PointController _pointController = PointController();
  List<PointLocation> pontos = [];
  LatLng? localizacaoAtual;
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    _buscarLocalizacao();
  }

  Future<void> _buscarLocalizacao() async {
    setState(() => carregando = true);
    try {
      final localizacao = await _pointController.pegarPontoLocalizacao();
      setState(() {
        localizacaoAtual = LatLng(localizacao.latitude, localizacao.longitude);
      });
    } catch (e) {
      _mostrarMensagem('Erro: $e');
    } finally {
      setState(() => carregando = false);
    }
  }

  Future<void> _baterPonto() async {
    setState(() => carregando = true);
    try {
      final novoPonto = await _pointController.pegarPontoLocalizacao();
      setState(() {
        localizacaoAtual = LatLng(novoPonto.latitude, novoPonto.longitude);
        pontos.add(novoPonto);
      });
      _mostrarMensagem('Ponto registrado!');
    } catch (e) {
      _mostrarMensagem('Erro: $e');
    } finally {
      setState(() => carregando = false);
    }
  }

  void _mostrarMensagem(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bate Ponto'),
        actions: [
          IconButton(
            onPressed: carregando ? null : _buscarLocalizacao,
            icon: carregando 
                ? const CircularProgressIndicator()
                : const Icon(Icons.gps_fixed),
          )
        ],
      ),
      body: Column(
        children: [
          // Card de informações
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Localização Atual', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  localizacaoAtual != null
                      ? Text('${localizacaoAtual!.latitude.toStringAsFixed(4)}, ${localizacaoAtual!.longitude.toStringAsFixed(4)}')
                      : const Text('Buscando...'),
                  const SizedBox(height: 8),
                  Text('Pontos hoje: ${pontos.length}'),
                ],
              ),
            ),
          ),

          // Mapa
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: localizacaoAtual ?? const LatLng(-22.3353, -47.2417),
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                if (localizacaoAtual != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: localizacaoAtual!,
                        child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: pontos
                    .take(20)
                    .map((ponto) => Marker(
                      point: LatLng(ponto.latitude, ponto.longitude),
                      child: const Icon(Icons.place, color: Colors.red, size: 30),
                    ))
                    .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: carregando ? null : _baterPonto,
        child: carregando ? const CircularProgressIndicator() : const Icon(Icons.place_outlined),
      ),
    );
  }
}