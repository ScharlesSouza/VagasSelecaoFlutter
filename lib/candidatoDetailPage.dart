import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPageCandidato extends StatelessWidget {
  var item;
  DetailPageCandidato(QueryDocumentSnapshot<Object?> item) {
    this.item = item;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Candidato: ' + item['nome'],
        )),
        body: Padding(
            padding: const EdgeInsets.all(50),
            child: new Column(children: <Widget>[
              Text('CPF: ' + item['cpf']),
              RaisedButton(
                onPressed: () {},
                child: new Text('Cadastrar Experiencias'),
              ),
            ])));
  }
}
