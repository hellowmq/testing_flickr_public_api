import 'dart:async';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

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
//        this.id,
//        this.owner,
//        this.secret,
//        this.server,
//        this.farm,
//        this.title,
//        this.ispublic,
//        this.isfriend,
//        this.isfamily

        return db.execute(
          "CREATE TABLE photos(id INTEGER PRIMARY KEY, "
              "owner TEXT, secret TEXT, server TEXT, farm"
              " TEXT, title TEXT, ispublic char(1), isfriend"
              " char(1), isfamily char(1))",
        );
      },
      version: 1,
    ).then((db) {
      getDataBaseInstance() = db;
    });
  }
}
