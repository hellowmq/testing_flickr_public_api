import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.getRecent.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

const String TAG = "SqfLiteTestPage";

class SqfLiteTestPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return SqfLiteTestPage();
  }

  @override
  _SqfLiteTestPageState createState() => _SqfLiteTestPageState();
}

class _SqfLiteTestPageState extends State<SqfLiteTestPage> {
  final database = LocalDataBase.getDataBaseInstance();
  List<Photo> _photos = List<Photo>();
  List<Widget> _widgetList = List<Widget>();

  void updateWidgetList() {
    setState(() {
      _widgetList = CommonBuilder.buildPhotoCardList(_photos);
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalDataBase.getPhotos().then((list) {
      _photos = list;
      updateWidgetList();
    });
    return Scaffold(
      body: ListView(
        children: _widgetList,
      ),
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Photo photo = await GetRecentPhotos()
                .request(
                    additionalParams: new Map<String, String>()
                      ..[FlickrConstant.PER_PAGE] = '5'
                      ..[FlickrConstant.PAGE] = '1')
                .then((v) => v[0]);
            this._photos = await LocalDataBase.getPhotos();
            print(
              TAG + "---Generate Photo Object---" + this._photos.toString(),
            );
            print(TAG +
                "---Generate Photo Object---" +
                photo.toJson().toString());

            LocalDataBase.insertPhoto(photo);
            this._photos = await LocalDataBase.getPhotos();
            print(
              TAG + "---Generate Photo Object---" + _photos.toString(),
            );
            updateWidgetList();
          }),
    );
  }
}
