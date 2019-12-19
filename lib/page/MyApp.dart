import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/base/global_settings.dart';
import 'package:wenmq_first_flickr_flutter_app/page/PageIndex.dart' as page;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: GlobalSetting.isDebug()
          ? GlobalSetting.defaultTheme
          : GlobalSetting.amberTheme,
      debugShowCheckedModeBanner: true,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
//      The routeMap of the whole application
      routes: page.routeMap,
    );
  }
}
