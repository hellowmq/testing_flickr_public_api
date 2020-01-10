import 'package:flutter/material.dart';

class AnimateRouter extends PageRouteBuilder {
  Widget widget;

  AnimateRouter(
    this.widget,
  ) : super(
          transitionDuration: const Duration(
            milliseconds: 500,
          ),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation1,
            Animation<double> animation2,
          ) {
            return widget;
          },
          transitionsBuilder: (
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
          },
        );
  WidgetBuilder widgetBuilder;

  AnimateRouter.fromWidgetBuilder(
      WidgetBuilder widgetBuilder, BuildContext buildContext)
      : widget = widgetBuilder(buildContext);
}
