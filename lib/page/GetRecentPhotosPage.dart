import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:wenmq_first_flickr_flutter_app/view_model/get_recent_photo.dart';
class GetRecentPhotosPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return GetRecentPhotosPage();
  }

  @override
  _GetRecentPhotosPageState createState() => _GetRecentPhotosPageState();
}

class _GetRecentPhotosPageState extends State<GetRecentPhotosPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  GetRecentViewModel _getRecentViewModel = new GetRecentViewModel();
  var dataList;
  var widgetList;
  var responseText = '未发送';
  bool _isSending = false;

//  bool _loadingDone = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text('GetRecent'),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios),
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
                      title: new Text('点击按钮获取最近图片'),
                      subtitle: new Text('如果无效请使用代理'),
                    ),
                     Container(
                      padding: EdgeInsets.all(30.0),
                      height: 150.0,
                      width: 150.0,
                      child: new Center(
                        child: _isSending
                            ? CircularProgressIndicator()
                            :  Container(
                                child: Text(''),
                              ),
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
//    _loadingDone = true;
    } catch (e) {
      ShowMessage.showSnackBar(key, e);
    }

    setState(() {
      _isSending = false;
    });
  }
}
