import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.getRecent.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class GetRecentPhotosPage extends StatefulWidget {
  @override
  _GetRecentPhotosPageState createState() => _GetRecentPhotosPageState();
}

class _GetRecentPhotosPageState extends State<GetRecentPhotosPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
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
                new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Text('点击按钮获取最近图片'),
                      subtitle: new Text('如果无效请使用代理'),
                    ),
                    new Container(
                      padding: EdgeInsets.all(30.0),
                      height: 150.0,
                      width: 150.0,
                      child: new Center(
                        child: _isSending
                            ? CircularProgressIndicator()
                            : new Container(
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
      dataList = await GetRecentPhotos().request();
      widgetList = GetRecentPhotos.buildPhotoCardList(dataList);
//    _loadingDone = true;
    } catch (e) {
      ShowMessage.showSnackBar(key, e);
    }

    setState(() {
      _isSending = false;
    });
  }
}
