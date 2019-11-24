import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/flickr.test.echo.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

/// This page [EchoTestPage] show an example of echo test with a word.
class EchoTestPage extends StatefulWidget {
  /// a static method help to call this page as a [WidgetBuilder]
  static Widget startPage(BuildContext context) {
    return EchoTestPage();
  }

  @override
  _EchoTestPageState createState() => _EchoTestPageState();
}

class _EchoTestPageState extends State<EchoTestPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  String echoText = '未发送';
  static TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Echo'),
        leading: IconButton(
            icon: CommonBuilder.iconBack,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _sendMessage(context),
          child: Icon(Icons.send),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
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

  _sendMessage(BuildContext context) async {
    if (_controller.text.isNotEmpty) {
      EchoTest().newRequest(_controller.text, onSuccess: (newText) {
        if (newText != null && newText.isNotEmpty) {
          setState(() {
            echoText = newText;
            print(echoText);
          });
        }
      }, onError: (e, r) {
        ShowMessage.showSnackBarWithContext(context, e);
      });
    }
  }
}
