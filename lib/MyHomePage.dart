import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_selecao/AppBarMenu.dart';
import 'package:flutter_selecao/shared/themes/app_collors.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  static String tag = '/home';
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference candidatos =
      FirebaseFirestore.instance.collection('Candidato');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new ReusableAppBar(context).getAppBar(widget.title),
      body: Center(
        child: StreamBuilder(
            stream: candidatos.where('').orderBy('nome').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //verificações de stream
              if (!snapshot.hasData) {
                return Center(child: Text('Loading: Nenhuma tarefa ainda'));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Center(child: Text('Loading'));
              }

              //retorna um listView com os dados
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, int i) {
                    var candidato = snapshot.data!.docs[i].data();
                    return ListTile(
                      leading: Icon(Icons.account_box),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => null,
                      ),
                      title: Text(candidato.toString()),
                      //subtitle: Text(candidato!['login']),
                    );
                  });
              /*
              return ListView(
                children: snapshot.data!.docs.map((candidato) {
                  return Center(
                    child: ListTile(
                      title: Text(candidato['nome']),
                    ),
                  );
                }).toList(),
              ); //ListView 
              */
            }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: showDialogAdd,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: AppColors.green,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String campo = "";
  void showDialogAdd() {
    String campo;

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    setState(() {});
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Cadastro Empresa"),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidate: true,
                child: _formUI(),
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  candidatos.add({
                    'login': 'scharles1',
                    'senha': 'senha12311',
                    'nome': 'Scharles Souza111'
                  });
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          );
        });
  }

  Widget _formUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Empresa"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campo = val;
          },
        ),
        new TextFormField(
          maxLength: 40,
          decoration: InputDecoration(
              hintText: 'Nome Completo',
              border: OutlineInputBorder(),
              labelText: "Empresa"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campo = val;
          },
        ),
        new TextFormField(
          decoration: InputDecoration(
              hintText: 'Nome Completo',
              border: OutlineInputBorder(),
              labelText: "Empresa"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campo = val;
          },
        ),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: () {},
          child: new Text('Enviar'),
        )
      ],
    );
  }
}
