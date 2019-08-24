import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.test.echo.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class EchoTestPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return EchoTestPage();
  }

  @override
  _EchoTestPageState createState() => _EchoTestPageState();
}

class _EchoTestPageState extends State<EchoTestPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  String echoText = '未发送';
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text('Echo'),
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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
          ),
          new Container(
            height: 100,
            width: 300,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(echoText),
            ),
          )
        ],
      ),
    );
  }

  _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String newText;
      try {
        newText = await EchoTest().request(_controller.text);
      } catch (e) {
        ShowMessage.showSnackBar(key, e);
      }
      if (newText != null && newText.isNotEmpty) {
        setState(() {
//        echoText;
          echoText = newText;
          print(echoText);
        });
      } else {}
    }
  }
}
