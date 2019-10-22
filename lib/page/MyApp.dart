import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/global_settings.dart';
import 'package:wenmq_first_flickr_flutter_app/page/PageIndex.dart' as page;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: GlobalSetting.theme,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
//      The routeMap og the whole application
      routes: page.routeMap,
    );
  }
}
