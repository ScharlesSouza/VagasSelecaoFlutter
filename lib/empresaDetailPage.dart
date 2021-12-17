import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPageEmpresa extends StatelessWidget {
  var item;
  DetailPageEmpresa(QueryDocumentSnapshot<Object?> item) {
    this.item = item;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Empresa: ' + item['razaoSocial'],
        )),
        body: Padding(
            padding: const EdgeInsets.all(50),
            child: new Column(children: <Widget>[
              Text('Area de atuação: ' + item['areaAtuacao']),
              RaisedButton(
                onPressed: () {},
                child: new Text('Cadastrar vagas'),
              ),
            ])));
  }
}
