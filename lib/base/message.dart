import 'package:flutter/material.dart';

class ShowMessage {
  static showSnackBar(GlobalKey<ScaffoldState> key, dynamic message) {
    key.currentState
        .showSnackBar(new SnackBar(content: Text(message.toString())));
  }

  static List<String> logger = new List();

  static printLog(object, {String tag}) {
    if (tag == null) tag = "";
    String log = "testing_flickr_public_api: tag=" + tag + object.toString();
    print(log);
    logger.add(log);
  }
}
