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
  GetPhotoListViewModel _getRecentViewModel =
      GetPhotoListViewModelBuilder.getRecentViewModel();
  var dataList;
  var widgetList;
  var responseText = '未发送';
  bool _isSending = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text('GetRecent'),
        leading: new IconButton(
            icon: ViewBuilder.iconBack,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        child: Icon(Icons.send),
      ),
      body: ListView(
        children: ((dataList != null) && (!_isSending))
            ? widgetList
            : <Widget>[
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('点击按钮获取最近图片'),
                      subtitle: const Text('如果无效请使用代理'),
                    ),
                    Container(
                      padding: EdgeInsets.all(30.0),
                      height: 150.0,
                      width: 150.0,
                      child: new Center(
                        child: _isSending
                            ? CircularProgressIndicator()
                            : Container(),
                      ),
                    ),
                  ],
                )
              ],
      ),
    );
  }

  _sendMessage() async {
    setState(() {
      _isSending = true;
    });
    try {
      await _getRecentViewModel.loadMorePhotoList();
      dataList = _getRecentViewModel.photoList;
      widgetList = ViewBuilder.buildPhotoCardList(dataList);
    } catch (e) {
      ShowMessage.showSnackBar(key, e);
    }

    setState(() {
      _isSending = false;
    });
  }
}
