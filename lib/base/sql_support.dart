import 'dart:async';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

import 'bean/photo.dart';

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
          "CREATE TABLE photos(id TEXT PRIMARY KEY, "
          "owner TEXT, secret TEXT, server TEXT, farm"
          " TEXT, title TEXT, ispublic TEXT, isfriend"
          " TEXT, isfamily TEXT)",
        );
      },
      version: 1,
    ).then((db) {
      _database = db;
      MQLogger.debugPrint("photo_database.db not open" + (_database == null).toString());
      print(_database);
    });
  }

  static Future<void> insertPhoto(Photo photo) async {
    final Database database = getDataBaseInstance();
    if (database == null) {
      throw Exception("Database not open");
    }
    await database.insert(
      'photos',
      photo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertPhotoList(List<Photo> photoList) async {
    final Database database = getDataBaseInstance();
    if (database == null) {
      throw Exception("Database not open");
    }
    photoList.forEach(
      (p) => database.insert(
        'photos',
        p.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  static Future<void> clearPhotoDatabase() async{
    final Database database = getDataBaseInstance();
    if(database == null){
      throw Exception("Database not open");
    }
    database.execute("DROP TABLE " + "photos");

  }

  static Future<List<Photo>> getPhotos() async {
    final database = getDataBaseInstance();
    if (database == null) {
      throw Exception("Database not open");
    }
    final List<Map<String, dynamic>> maps = await database.query("photos");
    return List.generate(
      maps.length,
      (i) => Photo.fromDatabaseMap(maps[i]),
    );
  }

  static Future<void> deletePhoto(String id) async {
    final database = getDataBaseInstance();
    if (database == null) {
      throw Exception("Database not open");
    }
    await database.delete(
      'photos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> updatePhoto(Photo photo) async {
    final database = getDataBaseInstance();
    if (database == null) {
      throw Exception("Database not open");
    }
    await database.update(
      'photos',
      photo.toJson(),
      where: "id = ?",
      whereArgs: [photo.id],
    );
  }
}
