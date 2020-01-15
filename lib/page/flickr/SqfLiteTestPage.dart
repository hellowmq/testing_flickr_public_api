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
  List<Photo> _photos = List<Photo>();
  List<Widget> _widgetList = List<Widget>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialGetLocalData();
  }

  initialGetLocalData() async {
    LocalDataBase.getDataBaseInstance();
    try {
      this._photos = await LocalDataBase.getPhotos();
      updateWidgetList();
    } catch (e) {
      MQLogger.debugPrint(e.toString(), logger: LocalDataBase.TAG);
    }
  }

  void updateWidgetList() {
    setState(() {
      _widgetList = CommonBuilder.buildPhotoCardList(_photos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _widgetList,
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => getRecentPhoto(context),
          child: Icon(Icons.send),
        ),
      ),
    );
  }

  GetPhotoListViewModel _mViewModel = (GetPhotoListViewModelBuilder()
        ..methodName = FlickrConstant.FLICKR_PHOTOS_GET_RECENT
        ..perPage = 1)
      .build();

  void getRecentPhoto(BuildContext context) async {
    _mViewModel.loadMorePhotoListWithCallback(
      onSuccessCallback: (List<Photo> photoList) async {
        this._photos = await LocalDataBase.getPhotos();
        MQLogger.debugPrint("Get Photo Object" + this._photos.toString(),
            logger: TAG);
        Photo first = photoList[0];
        print(first);
        MQLogger.debugPrint("Generate Photo Object" + first.toJson().toString(),
            logger: TAG);
        await LocalDataBase.insertPhoto(first);
        this._photos = await LocalDataBase.getPhotos();
        MQLogger.debugPrint(
            "After insert Photo Object" + this._photos.toString(),
            logger: TAG);
        updateWidgetList();
      },
      onErrorCallback: (e, response) {
        print(e.toString());
        ShowMessage.showSnackBarWithContext(context, e.toString());
      },
    );
  }
}
