import 'dart:async';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import 'Photo.dart';

class LocalDataBase {
  static Database _database;

  static Database getDataBaseInstance() {
    if (_database == null) {
      initDatabase();
    }
    return _database;
  }

  static initDatabase() async {
    openDatabase(
      join(await getDatabasesPath(), "photo_database.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE photos(id INTEGER PRIMARY KEY, "
          "owner TEXT, secret TEXT, server TEXT, farm"
          " TEXT, title TEXT, ispublic char(1), isfriend"
          " char(1), isfamily char(1))",
        );
      },
      version: 1,
    ).then((db) {
      _database = db;
    });
  }

  static Future<void> insertPhoto(Photo photo) async {
    final Database database = _database;
    if (database == null) {
      throw Exception("Database not open");
    }
    await database.insert(
      'photos',
      photo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Photo>> getPhotos() async {
    final database = _database;
    final List<Map<String, dynamic>> maps = await database.query("photos");
    return List.generate(
      maps.length,
      (i) => Photo.fromJson(maps[i]),
    );
  }
}
