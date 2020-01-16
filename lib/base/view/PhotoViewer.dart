import 'package:flutter/material.dart';

import 'package:wenmq_first_flickr_flutter_app/base/view/RadialExpansion.dart';
import 'package:intl/intl.dart';

class PhotoViewer extends StatelessWidget {
  PhotoViewer(this.widget,
      {Key key, this.heroTag, this.onTap, this.onLongPress})
      : super(key: key);

  final Widget widget;
  final String heroTag;
  final VoidCallback onTap;
  VoidCallback onLongPress;

  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Hero(
        tag: heroTag,
        child: new Material(
          color: Colors.transparent,
          child: new InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: widget,
          ),
        ),
      ),
    );
  }
}

/// This is a Sample for use PhotoView as a Hero Photo.
///
/// DO NOT forget to set a unique [String] heroTag

class PhotoViewWithBasePage extends StatelessWidget {
  final Widget widget;

  final String heroTag;
  final String uniqueTag;
  final bool onTapPopContext;

  PhotoViewWithBasePage(this.widget, this.heroTag,
      {Key key, this.uniqueTag, this.onTapPopContext = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new PhotoViewer(
      widget,
      heroTag: heroTag,
      onTap: () => onTapPhotoViewer(context),
    );
  }

  void onTapPhotoViewer(BuildContext context) {
    Navigator.of(context)
        .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new Scaffold(
        body: new Container(
          // The blue background emphasizes that it's a new route.
          color: Colors.lightBlueAccent,
          alignment: Alignment.center,
          child: new SizedBox(
            width: double.infinity,
            child: Tooltip(
              message: DateFormat.yMMMMEEEEd().format(DateTime.now()) +
                  " " +
                  DateFormat.Hms().format(DateTime.now()),
              child: new PhotoViewer(
                widget,
                heroTag: heroTag,
                onTap: () {
                  if (onTapPopContext) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (BuildContext c) {
                      return RadialExpansionDemo(uniqueTag);
                    }));
                  }
                },
              ),
            ),
          ),
        ),
      );
    }));
  }
}
