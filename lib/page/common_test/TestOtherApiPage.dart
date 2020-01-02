import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/jirengu_api/jirengu_api.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class TestOtherApiPage extends StatefulWidget {
  @override
  _TestOtherApiPageState createState() => _TestOtherApiPageState();
}

class _TestOtherApiPageState extends State<TestOtherApiPage> {
  String text = "default text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () => _sendMessage(context),
        ),
      ),
      appBar: AppBar(
        title: Text(this.toString()),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }

  _sendMessage(BuildContext context) {
    GetWeather.getWeather((WeatherBean bean) {
      setState(() {
        text = bean.toString();
      });
    }, (e, re) {
      MQLogger.debugPrint(e);
      ShowMessage.showSnackBarWithContext(context, e.toString());
      MQLogger.debugPrint(re);
    });
  }
}
