import 'package:flutter/material.dart';

import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'PageIndex.dart' as page;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(DebugUtils.isDebug ? 'This is our Flickr Api' : ''),
      ),
      body: ListView(
        children: page.buildPageIndexWidgetList(context),
      ),
    );
  }
}
