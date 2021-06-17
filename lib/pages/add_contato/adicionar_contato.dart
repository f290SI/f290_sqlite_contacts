import 'package:flutter/material.dart';

class AdicionarContatoPage extends StatefulWidget {
  const AdicionarContatoPage({Key key}) : super(key: key);

  @override
  _AdicionarContatoPageState createState() => _AdicionarContatoPageState();
}

class _AdicionarContatoPageState extends State<AdicionarContatoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Contacts'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.text_fields),
              hintText: 'Digite seu ome completo',
              labelText: 'Nome completo',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal.shade200),
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5))),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('SALVAR'),
      ),
    );
  }
}
