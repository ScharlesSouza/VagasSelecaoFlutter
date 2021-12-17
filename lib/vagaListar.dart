import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_selecao/AppBarMenu.dart';
import 'package:flutter_selecao/empresaDetailPage.dart';
import 'package:flutter_selecao/shared/themes/app_collors.dart';

class VagaPage extends StatefulWidget {
  VagaPage({Key? key, required this.title}) : super(key: key);

  static String tag = '/vagaListar';
  final String title;

  @override
  _VagaPageState createState() => _VagaPageState();
}

class _VagaPageState extends State<VagaPage> {
  CollectionReference vagas = FirebaseFirestore.instance.collection('Vaga');
  CollectionReference empresas =
      FirebaseFirestore.instance.collection('Empresa');

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
            stream: vagas.where('').orderBy('cargo').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //verificações de stream
              if (!snapshot.hasData) {
                return Center(child: Text('Loading: Nenhum dado ainda'));
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
                    var vaga = snapshot.data!.docs[i];
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
                                      'Esta ação irá remover a vaga selecionada'),
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
                                        vagas.doc(vaga.id).delete();
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
                      title: Text(vaga['cargo']), //empresa.data().toString()
                      subtitle:
                          Text("Empecificação: " + vaga.get('especificacao')),
                      onLongPress: () => {},
                      onTap: () {
                        showDetail(vaga);
                      },
                    );
                  });
            }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: reusarAppBar.irPaginaEmpresaCadastrar,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: AppColors.green,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void showDetail(QueryDocumentSnapshot<Object?> vaga) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPageEmpresa(vaga)));
  }
}
