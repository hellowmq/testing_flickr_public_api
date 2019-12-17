import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class ShowMessage {
  static showSnackBar(GlobalKey<ScaffoldState> key, dynamic message) {
    key.currentState
        .showSnackBar(new SnackBar(content: Text(message.toString())));
  }
  /// A sample to pass the context as a parameter. THe context of Scaffold
  /// can not be used as the context of a child of Scaffold.
//
//        floatingActionButton: Builder(
//        builder: (context) => FloatingActionButton(
//          onPressed: () {
//            _sendMessage(context);
//          },
//          child: Icon(Icons.send),
//        ),

  static showSnackBarWithContext(BuildContext context, dynamic message) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: Text(message.toString())));
    MQLogger.debugPrint(message,logger: context.findRenderObject());
  }

  /// Actually a Logger with key-value structure and factory function class is needed.
  static List<String> logger = new List();

  static printLog(object, {String tag}) {
    if (tag == null) tag = "";
    String log = "testing_flickr_public_api: tag=" + tag + object.toString();
    print(log);
    logger.add(log);
  }
}
