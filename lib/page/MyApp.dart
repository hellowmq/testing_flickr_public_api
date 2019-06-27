import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/page/PageIndex.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: routeMap,
    );
  }
}
