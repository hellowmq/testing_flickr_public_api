import 'package:flutter/material.dart';

import 'PageIndex.dart' as page;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('This is our Flickr Api'),
      ),
      body: ListView(
        children: page.buildPageIndexWidgetList(context),
      ),
    );
  }
}
