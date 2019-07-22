import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.search.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class SearchPhotosPage extends StatefulWidget {
  @override
  _SearchPhotosPageState createState() => _SearchPhotosPageState();
}

class _SearchPhotosPageState extends State<SearchPhotosPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var dataList;
  List<Widget> widgetList;
  var responseText = '未发送';
  bool _isSending = false;
  static TextEditingController _controller = TextEditingController();

//  bool _loadingDone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text('SearchPhoto'),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _searchPhoto,
        child: Icon(Icons.search),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13.0),
            child: Form(
              child: TextFormField(
                onFieldSubmitted: (str) {
                  _searchPhoto();
                },
                controller: _controller,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: '输入关键字进行检索',
                ),
              ),
            ),
          ),
          Column(
            children: ((dataList != null) && (!_isSending))
                ? widgetList
                : <Widget>[
                    new ListTile(
                      title: new Text('点击按钮搜索相关图片'),
                      subtitle: new Text('如果无效请使用代理'),
                    ),
                    new Container(
                      padding: EdgeInsets.all(30.0),
                      height: 150.0,
                      width: 150.0,
                      child: new Center(
                        child: _isSending
                            ? CircularProgressIndicator()
                            : new Divider(),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }

  _searchPhoto() async {
    setState(() {
      _isSending = true;
    });

    if (_controller.text.isNotEmpty) {
      try {
        dataList = await SearchPhotos()
            .request(additionalParams: {'text': _controller.text});
        widgetList = SearchPhotos.buildPhotoCardList(dataList);
      } catch (e) {
        ShowMessage.showSnackBar(key, e);
      }
    }
//    _loadingDone = true;
    setState(() {
      _isSending = false;
    });
  }
}