import 'package:flutter/material.dart';
import 'package:tarefas_app/views/lista.page.dart';
import 'package:tarefas_app/views/nova.page.dart';
import 'edita.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ListaPage(),
        '/pageAddItem': (context) => NovaPage(),
        '/pageEditar': (context) => EditaPage(),
      },
      initialRoute: '/',
    );
  }
}
