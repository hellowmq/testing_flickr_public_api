import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:wenmq_first_flickr_flutter_app/view_model/get_photo_list_model.dart';

class GetPopularPhotosPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return GetPopularPhotosPage();
  }

  @override
  _GetPopularPhotosPageState createState() => _GetPopularPhotosPageState();
}

class _GetPopularPhotosPageState extends State<GetPopularPhotosPage> {
  GetPhotoListViewModel _photoListViewModel = (GetPhotoListViewModelBuilder()
        ..methodName = FlickrConstant.FLICKR_PHOTOS_GET_POPULAR
        ..perPage = 10)
      .build();
  List<Widget> widgetList = new List();
  bool _isSending = false;
  static TextEditingController _controller = TextEditingController(
    text: '46627222@N03',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchPhoto'),
        leading: IconButton(
          icon: ViewBuilder.iconBack,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _searchPhoto(context),
          child: Icon(Icons.search),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 13.0,
            ),
            child: Form(
              child: Builder(
                builder: (context) => TextFormField(
                  onFieldSubmitted: (str) {
                    _searchPhoto(context);
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
          ),
          Column(
            children: (!_isSending)
                ? widgetList ?? []
                : <Widget>[
                    new ListTile(
                      title: new Text('正在获取热门图片'),
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
          ),
        ],
      ),
    );
  }

  _searchPhoto(BuildContext context) async {
    showLoading(true);
    _photoListViewModel.loadMorePhotoListWithCallback(
        additionalParams: {QueryKeyConstant.USER_ID: _controller.text},
        onSuccessCallback: onSearchPhotoSuccess,
        onErrorCallback: (Exception e, response) =>
            onSearchPhotoError(context, e));
  }

  void onSearchPhotoSuccess(List<Photo> dataList) {
    widgetList = ViewBuilder.buildPhotoCardList(dataList);
    showLoading(false);
  }

  void onSearchPhotoError(BuildContext context, Exception e) {
    ShowMessage.showSnackBarWithContext(context, e);
    showLoading(false);
  }

  void showLoading(bool visible) {
    setState(() {
      _isSending = visible;
    });
  }
}
