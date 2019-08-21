import 'package:flutter/material.dart';

class ShowMessage {
  static showSnackBar(GlobalKey<ScaffoldState> key, dynamic message) {
    key.currentState
        .showSnackBar(new SnackBar(content: Text(message.toString())));
  }
}
