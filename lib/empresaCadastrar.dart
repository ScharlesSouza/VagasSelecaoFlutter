import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

//https://pub.dev/packages/brasil_fields
class EmpresaCadastro extends StatefulWidget {
  EmpresaCadastro({Key? key, required this.title}) : super(key: key);

  static String tag = '/empresaCadastrar';
  final String title;

  @override
  _EmpresaCadastroState createState() => _EmpresaCadastroState();
}

class _EmpresaCadastroState extends State<EmpresaCadastro> {
  CollectionReference empresas =
      FirebaseFirestore.instance.collection('Empresa');

  var campoLogin = "",
      campoSenha = "",
      campoRazaoSocial = "",
      campoCNPJ = "",
      campoAreaAtuacao = "",
      campoEndereco = "",
      campoBairro = "",
      campoCidade = "",
      campoEmail = "";
  var campoTelefone = 0, campoFAX = 0, campoCEP = 0;
  var _cidades = ['AM', 'AP', 'BA', 'TO'];
  String campoUF = 'TO';
  bool isSwitched = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: _formUI(),
          ),
          autovalidate: true,
        ),
      )),
    );
  }

  Widget _formUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          autofocus: true,
          maxLength: 50,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Nome Empresa"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoRazaoSocial = val;
          },
        ),
        new TextFormField(
          maxLength: 30,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "Login"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoLogin = val;
          },
        ),
        new TextFormField(
          maxLength: 30,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "Senha"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.visiblePassword,
          onChanged: (val) {
            campoSenha = val;
          },
        ),
        new TextFormField(
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "CNPJ"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            CnpjInputFormatter()
          ],
          onChanged: (val) {
            campoCNPJ = val;
          },
        ),
        new TextFormField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Area Atuação"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoAreaAtuacao = val;
          },
        ),
        new TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Endereço"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoEndereco = val;
          },
        ),
        new TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Bairro"),
          validator: (val) => val!.isEmpty ? "Preencha o campo!" : null,
          onChanged: (val) {
            campoBairro = val;
          },
        ),
        DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Estado"),
            validator: (val) => val == null ? "Selecione o Estado" : null,
            items: _cidades.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (String? novoItemSelecionado) {
              setState(() {
                this.campoUF = novoItemSelecionado!;
              });
            },
            value: campoUF),
        new TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Cidade"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoCidade = val;
          },
        ),
        new TextFormField(
          autofocus: true,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "CEP"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.number,
          inputFormatters: [
            //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          onChanged: (val) {
            campoCEP = int.parse(val);
          },
        ),
        new TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "E-mail"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.emailAddress,
          inputFormatters: <TextInputFormatter>[
            //FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")),
          ],
          onChanged: (val) {
            campoEmail = val;
          },
        ),
        new TextFormField(
          //maxLength: 40,
          decoration: InputDecoration(
              //hintText: 'Nome Completo',
              border: OutlineInputBorder(),
              labelText: "Telefone Comercial"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter()
          ],
          onChanged: (val) {
            campoTelefone = int.parse(val);
          },
        ),
        TextFormField(
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "FAX"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter()
          ],
          onChanged: (val) {
            campoFAX = int.parse(val);
          },
        ),
        Row(
          children: <Widget>[
            Text('Receber Noticias?'),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(isSwitched);
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        ),
        RaisedButton(
          onPressed: () {
            empresas.add({
              'login': campoLogin,
              'senha': campoSenha,
              'razaoSocial': campoRazaoSocial,
              'cnpj': campoCNPJ,
              'areaAtuacao': campoAreaAtuacao,
              'endereco': campoEndereco,
              'bairro': campoEndereco,
              'uf': campoUF,
              'cidade': campoCidade,
              'cep': campoCEP,
              'email': campoEmail,
              'telefoneComercial': campoTelefone,
              'fax': campoFAX,
              'noticiasEmail': isSwitched
            });
            Navigator.pop(context);
          },
          child: new Text('Enviar'),
        )
      ],
    );
  }

  Widget BotaoCadastrar() {
    return RaisedButton(
      onPressed: () {
        empresas.add({
          'login': campoLogin,
          'senha': campoSenha,
          'razaoSocial': campoRazaoSocial,
          'cnpj': campoCNPJ,
          'areaAtuacao': campoAreaAtuacao,
          'endereco': campoEndereco,
          'bairro': campoEndereco,
          'uf': campoUF,
          'cidade': campoCidade,
          'cep': campoCEP,
          'email': campoEmail,
          'telefoneComercial': campoTelefone,
          'fax': campoFAX,
          'noticiasEmail': isSwitched
        });
        Navigator.pop(context);
      },
      child: Text("Add"),
    );
  }
}
