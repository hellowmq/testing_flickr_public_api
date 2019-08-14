import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/sql_support.dart';

class SqfLiteTestPage extends StatefulWidget {
  @override
  _SqfLiteTestPageState createState() => _SqfLiteTestPageState();
}

class _SqfLiteTestPageState extends State<SqfLiteTestPage> {
  final database = LocalDataBase.getDataBaseInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
