import 'dart:io';
import 'package:dictionary/WordMeaningClass.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? database;

  Future<Database> createdatabase() async {
    Database db;
    Directory directory = await getApplicationDocumentsDirectory();
    String dbpath = join(directory.path, "databaseDic.db");
    if (File(dbpath).existsSync()) {
      db = await openDatabase(dbpath);
      return db;
    } else {
      var data = await rootBundle.load("Database/dictionary.db");
      List<int> byte =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbpath).writeAsBytes(byte, flush: true);
      db = await openDatabase(dbpath);
      return db;
    }
  }

  Future<List<words>> getdata(Database db) async {
    String sql = "Select word,nepali_meaning from DICTIONARY";
    List data = await db.rawQuery(sql);
    List<words> meaning = [];
    for (int i = 0; i < data.length; i++) {
      words objwords = words(data[i]["word"], data[i]["nepali_meaning"]);
      meaning.add(objwords);
    }
    return meaning;
  }
}
