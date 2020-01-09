import 'package:flutter/material.dart';

import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'PageIndex.dart' as page;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          DebugUtils.isDebug ? 'android' : 'This is our Flickr Api',
          style: TextStyle(fontFamily: 'Steiner', fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: page.PageIndexList().buildPageIndexWidgetList(context),
      ),
    );
  }
}
