import 'package:flutter/material.dart';
import 'package:flutter_selecao/candidatoCadastrar.dart';
import 'package:flutter_selecao/vagaCadastrar.dart';

import 'candidatoListar.dart';
import 'empresaCadastrar.dart';
import 'empresaListar.dart';
import 'vagaListar.dart';

class ReusableAppBar {
  BuildContext? contexto;
  ReusableAppBar(BuildContext context) {
    contexto = context;
  }

  getAppBar(String title) {
    return AppBar(
      title: Text(title),
      actions: [
        PopupMenuButton<int>(
            onSelected: (item) => onSelected(contexto!, item),
            itemBuilder: (context) => [
                  PopupMenuItem(value: 0, child: Text('Empresa')),
                  PopupMenuItem(value: 1, child: Text('Candidato')),
                  PopupMenuItem(value: 2, child: Text('Vaga')),
                  PopupMenuItem(value: 3, child: Text('Consultas')),
                ]),
      ],
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        irPaginaEmpresaListar();
        break;
      case 1:
        irPaginaCandidatoListar();
        break;
      case 2:
        irPaginaVagaListar();
        break;
      case 3:
        irPaginaVagaListar();
        break;
    }
  }

  void irPaginaEmpresaListar() {
    Navigator.push(
      contexto!,
      MaterialPageRoute(builder: (context) => EmpresaPage(title: 'Empresas')),
    );
  }

  //rota nomeada
  void irPaginaEmpresaCadastrar() {
    Navigator.pushNamed(contexto!, '/empresaCadastrar');
  }
  /*
          void irPaginaEmpresaCadastrar() {
            Navigator.push(
              contexto!,
              MaterialPageRoute(
                  builder: (context) => EmpresaCadastro(title: 'Cadastrar Empresa')),
            );
          }
          */

  void irPaginaCandidatoListar() {
    Navigator.push(
      contexto!,
      MaterialPageRoute(
          builder: (context) => CandidatoPage(title: 'Candidatos')),
    );
  }

  void irPaginaCandidatoCadastrar() {
    Navigator.push(
      contexto!,
      MaterialPageRoute(
          builder: (context) =>
              CandidatoCadastro(title: 'Cadastrar Candidato')),
    );
  }

  void irPaginaVagaListar() {
    Navigator.push(
      contexto!,
      MaterialPageRoute(builder: (context) => VagaPage(title: 'Vagas')),
    );
  }

  void irPaginaVagaCadastrar() {
    Navigator.push(
      contexto!,
      MaterialPageRoute(
          builder: (context) => VagaCadastro(title: 'Cadastrar vaga')),
    );
  }
}
