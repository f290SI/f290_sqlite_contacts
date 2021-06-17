import 'package:f290_sqlite_contacts/pages/add_contato/adicionar_contato.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: AdicionarContatoPage(),
    );
  }
}
