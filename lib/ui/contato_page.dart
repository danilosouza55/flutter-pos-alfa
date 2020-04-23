import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

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
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  criarCampoTexto("Nome", nomeController, TextInputType.text),
                  criarCampoTexto(
                      "Telefone", telefoneController, TextInputType.phone),
                  criarCampoTexto(
                      "E-mail", emailController, TextInputType.emailAddress),
                  criarCampoTexto(
                      "Mensagem", mensagemController, TextInputType.text),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Color(0xff000077),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.send,
                            size: 28,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Text(
                            "Enviar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      onPressed: enviarEmail,
                    ),
                  ),
                ],
              ),
          )
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

  Future<void> enviarEmail() async {
    String username = 'danilo.asouza1@gmail.com';
    String password = 'password';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Danilo Souza')
      ..recipients.add('destination@example.com')
      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Etanol x Gasolina :: ${DateTime.now()}'
      ..text = 'Nome ${nomeController.text}, telefone ${telefoneController
          .text},'
          ' email ${emailController.text}, mensagem ${mensagemController.text}';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());

      setState(() {
        nomeController.text = '';
        telefoneController.text = '';
        emailController.text = '';
        mensagemController.text = '';
      });
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
