import 'package:flutter/material.dart';

import 'PageIndex.dart' as page;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('test Flickr Api'),
      ),
      body: ListView(
        children: page.buildPageIndexList(context),
      ),
    );
  }
}
