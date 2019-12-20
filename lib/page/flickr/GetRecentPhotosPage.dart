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
  GetPhotoListViewModel _mViewModel = (GetPhotoListViewModelBuilder()
        ..methodName = FlickrConstant.FLICKR_PHOTOS_GET_RECENT
        ..perPage = 10)
      .build();
  List<Widget> widgetList = new List();
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetRecent'),
        leading: IconButton(
            icon: CommonBuilder.iconBack,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _getRecentPhoto(context),
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

  void _getRecentPhoto(BuildContext context) {
    showLoading(true);
    _mViewModel.loadMorePhotoListWithCallback(
        onSuccessCallback: (List<Photo> photoList) {
      widgetList = CommonBuilder.buildPhotoCardList(_mViewModel.photoList);
      showLoading(false);
    }, onErrorCallback: (e, response) {
      print(e.toString());
      ShowMessage.showSnackBarWithContext(context, e.toString());
    });
  }

  void showLoading(bool isVisible) {
    setState(() {
      _isSending = isVisible;
    });
  }
}
