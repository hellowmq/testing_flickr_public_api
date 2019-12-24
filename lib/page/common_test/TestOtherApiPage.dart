import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/jirengu_api/jirengu_api.dart';

class TestOtherApiPage extends StatefulWidget {
  @override
  _TestOtherApiPageState createState() => _TestOtherApiPageState();
}

class _TestOtherApiPageState extends State<TestOtherApiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
        },
      ),
    );
  }
}
