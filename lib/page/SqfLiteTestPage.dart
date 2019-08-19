import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.getRecent.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

const String TAG = "SqfLiteTestPage";

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
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Photo photo = await GetRecentPhotos().request().then((v) => v[0]);
            var photos = await LocalDataBase.getPhotos();
            print(
              TAG + "---Generate Photo Object---" + photos.toString(),
            );
            print(TAG +
                "---Generate Photo Object---" +
                photo.toJson().toString());

            LocalDataBase.insertPhoto(photo);
            photos = await LocalDataBase.getPhotos();
            print(
              TAG + "---Generate Photo Object---" + photos.toString(),
            );
          }),
    );
  }
}
