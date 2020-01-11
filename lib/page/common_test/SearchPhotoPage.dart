import 'package:flutter/material.dart';
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
  /// A [GetPhotoListViewModel] will auto load more photos in [List] if build
  /// with a specific method name and page size.
  GetPhotoListViewModel _getRecentViewModel = (GetPhotoListViewModelBuilder()
        ..methodName = FlickrConstant.FLICKR_PHOTOS_SEARCH
        ..perPage = 10)
      .build();

  /// Keep the photo in this page.
  List<Widget> _widgetList = <Widget>[];

  /// Keep a state of network to show loading.
  bool _isSending = false;

  /// Detect user input event.
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchPhoto'),
        leading: IconButton(
            icon: CommonBuilder.iconBack,
            onPressed: () => Navigator.pop(context)),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _searchPhoto(context, _controller.text),
          child: Icon(Icons.search),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 13.0),
            child: Form(
              child: Builder(
                builder: (context) => TextFormField(
                  onFieldSubmitted: (str) => _searchPhoto(context, str),
                  controller: _controller,
                  style: TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    labelText: '输入关键字进行检索',
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: ((!_isSending)
                ? _widgetList
                : <Widget>[
                    const ListTile(
                      title: Text('点击按钮搜索相关图片'),
                      subtitle: Text('如果无效请使用代理'),
                    ),
                    new Container(
                      padding: EdgeInsets.all(30.0),
                      height: 150.0,
                      width: 150.0,
                      child: Divider(),
                    ),
                  ]),
          ),
        ],
      ),
    );
  }

  /// A searchPhoto network method with updatePage on Success and Error handle
  /// on Error.
  void _searchPhoto(BuildContext context, String text) {
    if (text.isNotEmpty) {
      showLoading(true);
      _getRecentViewModel.loadMorePhotoListWithCallback(
        additionalParams: {QueryKeyConstant.TEXT: text},
        onSuccessCallback: (List<Photo> dataList) {
          _widgetList = CommonBuilder.buildPhotoCardList(dataList);
          showLoading(false);
        },
        onErrorCallback: (Exception e, response) {
          ShowMessage.showSnackBarWithContext(context, e);
          showLoading(false);
        },
      );
    }
  }

  /// Change the loading state and notify state.
  void showLoading(bool isVisible) {
    setState(() {
      _isSending = isVisible;
    });
  }
}
