import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class ShowMessage {
  static bool shouldIgnoreNullContext = false;

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
    if (context == null) {
      assert(() {
        if (!shouldIgnoreNullContext) {
          MQLogger.debugPrint(
              "showSnackBarWithContext:  get a null Context, This mean a message has bean ignored",
              logger: ShowMessage);
        }
        return true;
      }());
      return;
    }
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: Text(message.toString())));
    MQLogger.debugPrint(message, logger: context.findRenderObject());
  }
}
