import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dog.dart';

class DogController {
  late Future<Database> _database = _getDatabase();

  DogController() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      // set the database path
      join(await getDatabasesPath(), 'doggie_database.db'),

      // create the dogs db on wake
      onCreate: ((db, version) => db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)"
      )),
      // the version will be the one to determine the oncreate
      // is executed or not
      version: 1
    );
  }

  Future<void> insertDog(Dog dog) async {
    (await _database).insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Dog>> dogs() async {
    final List<Map<String, dynamic>> maps = await (await _database).query('dogs');

    return List.generate(maps.length, (index) {
      final dogItem = maps[index];
      return Dog(id: dogItem['id'], name: dogItem['name'], age: dogItem['age']);
    });
  }

  Future<void> updateDog(Dog dog) async {
    (await _database).update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id] 
    );
  }
}
