import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tabela = 'contatos';
const String colunaId = 'id';
const String colunaNome = 'nome';
const String colunaEmail = 'email';
const String colunaTelefone = 'telefone';
const String colunaPathImagem = 'pathImagem';

class Contato {
  int id;
  String nome;
  String email;
  String telefone;
  String pathImagem;

  Contato({this.nome, this.email, this.telefone, this.pathImagem});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      colunaNome: nome,
      colunaEmail: email,
      colunaTelefone: telefone,
      colunaPathImagem: pathImagem
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Contato.fromMap(Map<String, dynamic> map)
      : id = map[colunaId],
        nome = map[colunaNome],
        email = map[colunaEmail],
        telefone = map[colunaTelefone],
        pathImagem = map[colunaPathImagem];

  @override
  String toString() {
    return "Contato(id=$id, nome=$nome, email=$email, telefone=$telefone, pathImagem=$pathImagem)";
  }
}

class SQLiteOpenHelper {
  SQLiteOpenHelper.internal();

  static final SQLiteOpenHelper _instance = SQLiteOpenHelper.internal();
  factory SQLiteOpenHelper() => _instance;

  Database _dataBase;

  Future<Database> get dataBase async {
    if (_dataBase != null) {
      return _dataBase;
    } else {
      return _dataBase = await inicializarBancoDeDados();
    }
  }

  Future<Database> inicializarBancoDeDados() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contatos.db");

    final sql = '''
      CREATE TABLE IF NOT EXISTS $tabela(
        $colunaId INTEGER PRIMARY KEY,
        $colunaNome TEXT NOT NULL,
        $colunaEmail TEXT NOT NULL,
        $colunaTelefone TEXT NOT NULL,
        $colunaEmail TEXT,
        $colunaPathImagem TEXT,
      );
    ''';

    openDatabase(path, version: 1, onCreate: (Database db, int version) {
      db.execute(sql);
    });
  }

  Future<Contato> insert(Contato contato) async {
    Database db = await dataBase;
    contato.id = await db.insert(tabela, contato.toMap());
    return contato;
  }

  Future<Contato> findById(int id) async {
    Database db = await dataBase;

    List<Map<String, dynamic>> mapaRetorno = await db.query(tabela,
        distinct: true,
        columns: [
          colunaId,
          colunaNome,
          colunaEmail,
          colunaTelefone,
          colunaPathImagem
        ],
        where: '$colunaId = ?',
        whereArgs: [id]);

    return mapaRetorno.length > 0 ? Contato.fromMap(mapaRetorno.first) : Map();
  }

  Future<int> delete(int id) async {
    Database db = await dataBase;
    return await db.delete(tabela, where: '$colunaId = ?', whereArgs: [id]);
  }

  Future<int> update(Contato contato) async {
    Database db = await dataBase;
    return await db.update(tabela, contato.toMap(),
        where: '$colunaId = ?', whereArgs: [contato.id]);
  }

  Future<List<Contato>> findAll() async {
    Database db = await dataBase;

    List<Map<String, dynamic>> listReturn =
        await db.rawQuery('SELECT * FROM $tabela');

    List<Contato> contatos = [];

    listReturn.forEach((element) {
      contatos.add(Contato.fromMap(element));
    });

    return contatos;
  }

  Future<int> getCount() async {
    Database db = await dataBase;
    Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tabela'));
  }
}
