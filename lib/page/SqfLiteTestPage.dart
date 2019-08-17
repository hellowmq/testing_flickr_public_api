import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.getRecent.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class SqfLiteTestPage extends StatefulWidget {
  @override
  _SqfLiteTestPageState createState() => _SqfLiteTestPageState();
}

class _SqfLiteTestPageState extends State<SqfLiteTestPage> {
  final database = LocalDataBase.getDataBaseInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
      floatingActionButton: new FloatingActionButton(onPressed: () async {
        Photo photo = await GetRecentPhotos().request().then((v) => v[0]);
        debugPrint(photo.toJson().toString());

      }),
    );
  }
}
