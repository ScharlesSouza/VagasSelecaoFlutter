import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_selecao/candidatoListar.dart';
import 'package:flutter_selecao/empresaCadastrar.dart';
import 'package:flutter_selecao/shared/themes/app_collors.dart';

import 'MyHomePage.dart';
import 'empresaListar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();

  runApp(MyApp());
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
  print('Initialized default app $app');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Essa linha remove da tela a tag debug
      title: 'Vagas de emprego',
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      initialRoute: "/empresaListar", //ou EmpresaPage.tag
      routes: {
        //MyHomePage.tag: (context) => MyHomePage(title: 'Seleçao de empregos'),
        "/home": (context) => MyHomePage(title: 'Seleçao de empregos'),
        "/empresaListar": (context) => EmpresaPage(title: 'Empresas'),
        "/empresaCadastrar": (context) =>
            EmpresaCadastro(title: 'Cadastrar Empresa'),
        "/candidatoListar": (context) => CandidatoPage(title: 'Candidatos'),
      },
    );
  }
}
