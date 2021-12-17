import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//https://pub.dev/packages/brasil_fields
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class CandidatoCadastro extends StatefulWidget {
  CandidatoCadastro({Key? key, required this.title}) : super(key: key);

  static String tag = '/empresacadastrar';
  final String title;

  @override
  _CandidatoCadastroState createState() => _CandidatoCadastroState();
}

class _CandidatoCadastroState extends State<CandidatoCadastro> {
  CollectionReference candidatos =
      FirebaseFirestore.instance.collection('Candidato');

  var campoLogin = "",
      campoSenha = "",
      campoNome = "",
      campoOrgaoRG = "",
      campoDataExpRG = "",
      campoCPF = "",
      campoDataNasc = "",
      campoSexo = "",
      campoEstadoCivil = "",
      campoEndereco = "",
      campoTipoEndereco = "",
      campoBairro = "",
      campoCidade = "",
      campoTelefoneRes = "",
      campoCelular = "",
      campoCEP = "",
      campoEmail = "";
  var campoRG = 0;
  var _cidades = ['AM', 'AP', 'BA', 'TO'];
  String campoUF = 'TO', campoUFRG = 'TO';
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
          autovalidate: true,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _formUI(),
          ),
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
              border: OutlineInputBorder(), labelText: "Nome Candidato"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoNome = val;
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
              InputDecoration(border: OutlineInputBorder(), labelText: "CPF"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter()
          ],
          onChanged: (val) {
            campoCPF = val;
          },
        ),
        new TextFormField(
          maxLength: 11,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "RG"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (val) {
            campoRG = int.parse(val);
          },
        ),
        new TextFormField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Orgao Expedidor RG"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoOrgaoRG = val;
          },
        ),
        new TextFormField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Data Expedição RG"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            DataInputFormatter()
          ],
          onChanged: (val) {
            campoDataExpRG = val;
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
                this.campoUFRG = novoItemSelecionado!;
              });
            },
            value: campoUFRG),
        new TextFormField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Data Nascimento"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            DataInputFormatter()
          ],
          onChanged: (val) {
            campoDataNasc = val;
          },
        ),
        new TextFormField(
          maxLength: 9,
          autofocus: true,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "Sexo"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoSexo = val;
          },
        ),
        new TextFormField(
          maxLength: 8,
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Estado Civil"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Preencha o campo!";
            } else {
              return null;
            } //if
          }, //validator
          onChanged: (val) {
            campoEstadoCivil = val;
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
            campoCEP = val;
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
              labelText: "Telefone Residencial"),
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
            campoTelefoneRes = val;
          },
        ),
        new TextFormField(
          //maxLength: 40,
          decoration: InputDecoration(
              //hintText: 'Nome Completo',
              border: OutlineInputBorder(),
              labelText: "Telefone Celular"),
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
            campoCelular = val;
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
        new RaisedButton(
          onPressed: () {
            candidatos.add({
              'login': campoLogin,
              'senha': campoSenha,
              'nome': campoNome,
              'rg': campoRG,
              'orgaoExpedidorRG': campoOrgaoRG,
              'dataExpedicaoRG': campoDataExpRG,
              'ufExpedicaoRG': campoUFRG,
              'cpf': campoCPF,
              'dtNascimento': campoDataNasc,
              'sexo': campoSexo,
              'estadoCivil': campoEstadoCivil,
              'endereco': campoEndereco,
              'bairro': campoEndereco,
              'uf': campoUF,
              'cidade': campoCidade,
              'cep': campoCEP,
              'email': campoEmail,
              'telefoneResidencial': campoTelefoneRes,
              'telefoneCelular': campoCelular,
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
        candidatos.add({
          'login': campoLogin,
          'senha': campoSenha,
          'nome': campoNome,
          'rg': campoRG,
          'orgaoExpedidorRG': campoOrgaoRG,
          'dataExpedicaoRG': campoDataExpRG,
          'ufExpedicaoRG': campoUFRG,
          'cpf': campoCPF,
          'dtNascimento': campoDataNasc,
          'sexo': campoSexo,
          'estadoCivil': campoEstadoCivil,
          'endereco': campoEndereco,
          'bairro': campoEndereco,
          'uf': campoUF,
          'cidade': campoCidade,
          'cep': campoCEP,
          'email': campoEmail,
          'telefoneResidencial': campoTelefoneRes,
          'telefoneCelular': campoCelular,
          'noticiasEmail': isSwitched
        });
        Navigator.pop(context);
      },
      child: Text("Add"),
    );
  }
}
