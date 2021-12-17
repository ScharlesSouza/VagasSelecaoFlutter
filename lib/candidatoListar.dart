import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_selecao/AppBarMenu.dart';
import 'package:flutter_selecao/shared/themes/app_collors.dart';

import 'candidatoDetailPage.dart';

class CandidatoPage extends StatefulWidget {
  CandidatoPage({Key? key, required this.title}) : super(key: key);

  static String tag = '/candidatoListar';
  final String title;

  @override
  _CandidatoPageState createState() => _CandidatoPageState();
}

class _CandidatoPageState extends State<CandidatoPage> {
  CollectionReference candidatos =
      FirebaseFirestore.instance.collection('Candidato');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReusableAppBar reusarAppBar = new ReusableAppBar(context);

    return Scaffold(
      appBar: reusarAppBar.getAppBar(widget.title),
      body: Center(
        child: StreamBuilder(
            stream: candidatos.where('').orderBy('nome').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //verificações de stream
              if (!snapshot.hasData) {
                return Center(child: Text('Loading: Nenhuma dado ainda'));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              //retorna um listView com os dados
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, int i) {
                    var candidato = snapshot.data!.docs[i];
                    return ListTile(
                      leading: Icon(Icons.account_box),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Text('Tem certeza?'),
                                  content: Text(
                                      'Esta ação irá remover o candidato selecionado'),
                                  actions: [
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      color: AppColors.green,
                                      child: Text('Cancelar'),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        candidatos.doc(candidato.id).delete();
                                        Navigator.of(ctx).pop();
                                        //reusarAppBar.irPaginaCandidatoListar();
                                      },
                                      color: AppColors.danger,
                                      child: Text('Remover'),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      title: Text(candidato.get('nome')),
                      subtitle: Text(candidato['telefoneCelular']),
                      onLongPress: () => {},
                      onTap: () {
                        showDetail(candidato);
                      },
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reusarAppBar.irPaginaCandidatoCadastrar,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: AppColors.green,
      ),
    );
  }

  void showDetail(QueryDocumentSnapshot<Object?> candidato) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPageCandidato(candidato)));
  }
}
