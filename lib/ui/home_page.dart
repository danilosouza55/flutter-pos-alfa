import 'package:aula07032020/ui/contato_page.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final etanolController = new TextEditingController();
  final gasolinaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Etanol x Gasolina"),
          centerTitle: true,
          backgroundColor: Color(0xff000077),
          actions: <Widget>[
            criarBotaoBarra(Icons.share, compartilhar),
            criarBotaoBarra(Icons.mail, abrirContato),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text("Etanol x Gasolina",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                decoration: BoxDecoration(color: Color(0xff000077)),
              ),
              criarItemLista("Compartilhar", Icons.share, compartilhar),
              criarItemLista("Contato", Icons.mail, abrirContato),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            criarCampoTexto("Etanol", "R\$", etanolController),
            criarCampoTexto("Gasolina", "R\$", gasolinaController),
            Padding(
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                onPressed: calcular,
                color: Color(0xff000077),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void calcular() {
    if (etanolController.text.isEmpty) {
      showMessage("Atenção", "Digite o valor do etanol!");

      return;
    }

    if (gasolinaController.text.isEmpty) {
      showMessage("Atenção", "Digite o valor do gasolina!");

      return;
    }

    double valorEtanol = double.parse(etanolController.text);
    double valorGasolina = double.parse(gasolinaController.text);

    if (valorEtanol <= (valorGasolina * 0.7)) {
      showMessage("Etanol", "O etanol é mais vantajoso!");
    } else {
      showMessage("Gasolina", "Gasolina é mais vantajosa!");
    }
  }

  void showMessage(String titulo, String texto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(texto),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget criarCampoTexto(String texto, String prefix, TextEditingController c) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: TextField(
          controller: c,
          decoration: InputDecoration(
              labelText: texto,
              labelStyle: TextStyle(color: Color(0xff000077)),
              border: OutlineInputBorder(),
              prefixText: prefix),
          style: TextStyle(color: Color(0xff000077), fontSize: 25),
          keyboardType: TextInputType.number,
        ));
  }

  Widget criarBotaoBarra(IconData icon, Function func) {
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
        size: 32,
      ),
      onPressed: func,
    );
  }

  void compartilhar() {
    Share.share(
        "Etanol: R\$ ${etanolController.text} - Gasolina: R\$ ${gasolinaController.text}");
  }

  void abrirContato() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContatoPage()));
  }

  Widget criarItemLista(String texto, IconData icone, Function func) {
    return ListTile(
        title: Row(
      children: <Widget>[
        Icon(
          icone,
          color: Color(0xff000077),
        ),
        Text(
          texto,
          style: TextStyle(color: Color(0xff000077), fontSize: 16),
        )
      ],
    ));
  }
}
