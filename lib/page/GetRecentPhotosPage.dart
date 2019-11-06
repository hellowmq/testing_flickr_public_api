import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:wenmq_first_flickr_flutter_app/view_model/get_photo_list_model.dart';

class GetRecentPhotosPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return GetRecentPhotosPage();
  }

  @override
  _GetRecentPhotosPageState createState() => _GetRecentPhotosPageState();
}

class _GetRecentPhotosPageState extends State<GetRecentPhotosPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  GetPhotoListViewModel _getRecentViewModel = (GetPhotoListViewModelBuilder()
        ..methodName = FlickrConstant.FLICKR_PHOTOS_GET_RECENT
        ..perPage = 10)
      .build();
  List<Widget> widgetList = new List();
  var responseText = '未发送';
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('GetRecent'),
        leading: IconButton(
            icon: ViewBuilder.iconBack,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _sendMessage(context),
          child: Icon(Icons.send),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: widgetList,
          ),
          _isSending
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: Text(""),
                ),
        ],
      ),
    );
  }

  _sendMessage(BuildContext context) async {
    setState(() {
      _isSending = true;
    });
    _getRecentViewModel.loadMorePhotoListWithCallback(
        onSuccessCallback: (List<Photo> photoList) {
      print(_getRecentViewModel.photoList.length);
      widgetList =
          ViewBuilder.buildPhotoCardList(_getRecentViewModel.photoList);
      setState(() {
        _isSending = false;
      });
    }, onErrorCallback: (e, response) {
      print(e.toString());
      ShowMessage.showSnackBarWithContext(context, e.toString());
    });

//    try {
//      await _getRecentViewModel.loadMorePhotoList();
//      dataList = _getRecentViewModel.photoList;
//      widgetList = ViewBuilder.buildPhotoCardList(dataList);
//    } catch (e) {
//      ShowMessage.showSnackBar(key, e);
//    }
//
//    setState(() {
//      _isSending = false;
//    });
  }
}
