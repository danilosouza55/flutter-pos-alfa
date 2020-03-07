import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Contato'),
        centerTitle: true,
        backgroundColor: Color(0xff000077),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Column(
          children: <Widget>[
            criarCampoTexto("Nome", nomeController, TextInputType.text),
            criarCampoTexto(
                "Telefone", telefoneController, TextInputType.phone),
            criarCampoTexto(
                "E-mail", emailController, TextInputType.emailAddress),
            criarCampoTexto("Mensagem", mensagemController, TextInputType.text),
          ],
        ),
      ),
    );
  }

  Widget criarCampoTexto(String texto, TextEditingController campo,
      TextInputType textType) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: campo,
          keyboardType: textType,
          decoration: InputDecoration(
              labelText: texto,
              labelStyle: TextStyle(color: Color(0xff000077)),
              border: OutlineInputBorder()),
          style: TextStyle(color: Color(0xff000077), fontSize: 16),
        ),
    );
  }
}
