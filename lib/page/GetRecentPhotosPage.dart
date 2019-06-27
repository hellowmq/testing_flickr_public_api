import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.photos.getRecent.dart';

class GetRecentPhotosPage extends StatefulWidget {
  @override
  _GetRecentPhotosPageState createState() => _GetRecentPhotosPageState();
}

class _GetRecentPhotosPageState extends State<GetRecentPhotosPage> {
  var responseText = '未发送';
  TextEditingController _controller = TextEditingController();

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
        children: <Widget>[new Text(responseText)],
      ),
    );
  }

  _sendMessage() async {
    var newText = await GetRecentPhotos().request();
    if (newText.isNotEmpty) {
      setState(() {
        responseText = newText;
      });
    }
  }
}
