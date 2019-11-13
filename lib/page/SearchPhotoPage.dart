import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.search.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:wenmq_first_flickr_flutter_app/view_model/get_photo_list_model.dart';

/// This page [SearchPhotosPage] show an example of search photos list with a
/// key word.
class SearchPhotosPage extends StatefulWidget {
  /// a static method help to call this page as a [WidgetBuilder]
  static Widget startPage(BuildContext context) {
    return SearchPhotosPage();
  }

  @override
  _SearchPhotosPageState createState() => _SearchPhotosPageState();
}

class _SearchPhotosPageState extends State<SearchPhotosPage> {
  GetPhotoListViewModel _getRecentViewModel = (GetPhotoListViewModelBuilder()
        ..methodName = FlickrConstant.FLICKR_PHOTOS_SEARCH
        ..perPage = 10)
      .build();

  /// Call a dialog ny a [GlobalKey] is not a good idea obviously.
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

//  var dataList;
  List<Widget> widgetList;

  /// keep a state of network to show loading.
  bool _isSending = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text('SearchPhoto'),
        leading: new IconButton(
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
            children: (!_isSending)
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

  _searchPhoto() {
    if (_controller.text.isNotEmpty) {
      showLoading(true);
      _getRecentViewModel.loadMorePhotoListWithCallback(
        additionalParams: {'text': _controller.text},
        onSuccessCallback: (List<Photo> dataList) =>
            widgetList = ViewBuilder.buildPhotoCardList(dataList),
        onErrorCallback: (Exception e, response) =>
            ShowMessage.showSnackBar(key, e),
      );
      showLoading(false);
    }
  }

  void showLoading(bool isVisible) {
    setState(() {
      _isSending = isVisible;
    });
  }
}
