import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.getPopular.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class GetPopularPhotosPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return GetPopularPhotosPage();
  }

  @override
  _GetPopularPhotosPageState createState() => _GetPopularPhotosPageState();
}

class _GetPopularPhotosPageState extends State<GetPopularPhotosPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var dataList;
  List<Widget> widgetList;
  bool _isSending = false;
  static TextEditingController _controller = TextEditingController(
    text: '46627222@N03',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('SearchPhoto'),
        leading: IconButton(
            icon: ViewBuilder.iconBack,
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
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 13.0,
            ),
            child: Form(
              child: TextFormField(
                onFieldSubmitted: (str) {
                  _searchPhoto();
                },
                controller: _controller,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: '输入user_id进行查看',
                  hintText: '146621154@N02',
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
                            : const Divider(),
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
    try {
      if (_controller.text.isNotEmpty) {
        dataList = await GetPopularPhotos()
            .request(additionalParams: {'user_id': _controller.text});
      } else {
        dataList = await GetPopularPhotos().request();
      }
      widgetList = ViewBuilder.buildPhotoCardList(dataList);
    } catch (e) {
      ShowMessage.showSnackBar(key, e);
    }
    setState(() {
      _isSending = false;
    });
  }
}
