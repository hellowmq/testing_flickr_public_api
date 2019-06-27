import 'package:flutter/material.dart';

import 'PageIndex.dart' as page;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('test Flickr Api'),
      ),
      body: ListView(
        children: page.buildWidgetList(context),
      ),
    );
  }
}
