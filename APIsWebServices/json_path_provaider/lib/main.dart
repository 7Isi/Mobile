import 'dart:convert';
import 'dart:io'; //pacote de manipulação de arquivos
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    home: ProdutoPage(),
  ));
}

class ProdutoPage extends StatefulWidget {

  //contrutor
  const ProdutoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProdutoPageStage();
  }
}


class _ProdutoPageStage extends State<ProdutoPage> {

  List <Map<String, dynamic>> produtos = [];

  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _valorProdutoController = TextEditingController();


  //métodos da classe
  //método para iniciar o aplicativo
  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }


  //método para conexão com arquivo da base de dados
  Future <File> _getArquivo() async{
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/produtos.json");
  }

  //método para carregar as informaçõez da base de dados
  void _carregarProdutos() async {
    try {
      final file = await _getArquivo();

      String conteudo = await file.readAsString();
      List<dynamic> dados = json.decode(conteudo);

      setState(() {
        //converter a lista dinâmica para Lista de Map
        //cast é um método que converte o tipo de dado
        //nesse caso converte de List<dynamic> para List<Map<String,dynamic>>
        produtos = dados.cast<Map<String,dynamic>>();
      });
    } catch (e) {
      setState(() {
        produtos = [];
      });
    }
  }


  //método para salvamento
  void _salvarProdutos() async {
    try {
      final file = await _getArquivo();

      String jsonProdutos = json.encode(produtos);
      await file.writeAsString(jsonProdutos);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lista de Produtos Salva com Sucesso!"))
      );
    } catch (e) {
      print(e);
    }
  }


  //adicionar o produto da lista
  void _adicionarProduto() {
    String nome = _nomeProdutoController.text.trim();
    String valorStr = _valorProdutoController.text.trim();

    if(nome.isEmpty || valorStr.isEmpty) return;

    //converter o str em double
    double? valor = double.tryParse(valorStr);
    if(valor == null) return;

    final novoProduto = {"nome": nome, "valor": valor};

    setState(() {
      produtos.add(novoProduto);
    });

    _nomeProdutoController.clear();
    _valorProdutoController.clear();

    _salvarProdutos();
  }



  //remoção do produto da lista
  void _removerProduto (int index) {
    setState(() {
      produtos.removeAt(index);
    });

    _salvarProdutos();
  }




  //building da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Produtos"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeProdutoController,
              decoration: InputDecoration(labelText: "Nome do Produto"),
            ),

            TextField(
              controller: _valorProdutoController,
              decoration: InputDecoration(labelText: "Valor (ex: 15.50)"),
              keyboardType: TextInputType.numberWithOptions(),
            ),

            SizedBox(height: 10,),

            ElevatedButton(
              onPressed: _adicionarProduto,
              child: Text("Salvar Produto")),

            Divider(),

            Expanded(
              //operador ternario
              child: produtos.isEmpty ? 
                Center(child: Text("Nenhum Produto Salvo"),) :
                ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context,index) {
                    final produto = produtos[index];
                    return ListTile(
                      title: Text(produto["nome"]),
                      subtitle: Text("R\$ ${produto["valor"]}"),
                      trailing: IconButton(
                        onPressed: () => _removerProduto(index),
                        icon: Icon(Icons.delete)),
                    );
                  }
                )
            )
          ],
        ),
      ),
    );
  }


}