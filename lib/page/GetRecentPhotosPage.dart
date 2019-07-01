import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.getRecent.dart';

class GetRecentPhotosPage extends StatefulWidget {
  @override
  _GetRecentPhotosPageState createState() => _GetRecentPhotosPageState();
}

class _GetRecentPhotosPageState extends State<GetRecentPhotosPage> {
  var dataList;
  var responseText = '未发送';
  bool _isSending = false;
//  bool _loadingDone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ? dataList
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
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                )
              ],
      ),
    );
  }

  _sendMessage() async {
    _isSending = true;
    dataList = await GetRecentPhotos().request();
    _isSending = false;
//    _loadingDone = true;
    setState(() {});
  }
}
