import 'package:flutter/material.dart';

class GlobalSetting {
  static ThemeData defaultTheme = new ThemeData(
      primaryColor: Colors.blue,
      pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          }));

  myPageTransitionsTheme(
    BuildContext context,
    Animation<double> animation1,
    Animation<double> animation2,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(
          0.0,
          1.0,
        ),
        end: Offset(
          0.0,
          0.0,
        ),
      ).animate(
        CurvedAnimation(
          parent: animation1,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: child,
    );
  }

  static ThemeData amberTheme = new ThemeData(primaryColor: Colors.amber);
}
