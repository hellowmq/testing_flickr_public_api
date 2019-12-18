import 'package:flutter/material.dart';

class PhotoViewer extends StatelessWidget {
  PhotoViewer(this.widget, {Key key, this.heroTag, this.onTap})
      : super(key: key);

  final Widget widget;
  final String heroTag;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Hero(
        tag: heroTag,
        child: new Material(
          color: Colors.transparent,
          child: new InkWell(
            onTap: onTap,
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

  PhotoViewWithBasePage(this.widget, this.heroTag, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new PhotoViewer(
      widget,
      heroTag: heroTag,
      onTap: () {
        Navigator.of(context)
            .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Flippers Page'),
            ),
            body: new Container(
              // The blue background emphasizes that it's a new route.
              color: Colors.lightBlueAccent,
              alignment: Alignment.center,
              child: new PhotoViewer(
                widget,
                heroTag: heroTag,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }));
      },
    );
  }
}
