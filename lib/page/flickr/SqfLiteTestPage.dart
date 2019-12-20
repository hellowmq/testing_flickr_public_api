import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:wenmq_first_flickr_flutter_app/view_model/get_photo_list_model.dart';

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
          child: Icon(Icons.add), onPressed: getRecentPhoto),
    );
  }

  GetPhotoListViewModel _mViewModel = (GetPhotoListViewModelBuilder()
        ..methodName = FlickrConstant.FLICKR_PHOTOS_GET_RECENT
        ..perPage = 1)
      .build();

  void getRecentPhoto() async {
    _mViewModel.loadMorePhotoListWithCallback(
        onSuccessCallback: (List<Photo> photoList) async {
      Photo first = photoList[0];
      this._photos = await LocalDataBase.getPhotos();
      MQLogger.debugPrint("Generate Photo Object" + this._photos.toString(),
          logger: TAG);
      MQLogger.debugPrint("Generate Photo Object" + first.toJson().toString(),
          logger: TAG);
      LocalDataBase.insertPhoto(first);
      this._photos = await LocalDataBase.getPhotos();
      MQLogger.debugPrint("After insert Photo Object" + this._photos.toString(),
          logger: TAG);
      updateWidgetList();
    });
  }
}
