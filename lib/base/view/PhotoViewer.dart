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

//class HeroAnimation extends StatelessWidget {
//  Widget build(BuildContext context) {
//    var timeDilation = 5.0; // 1.0 means normal animation speed.
//
//    return new Scaffold(
//      appBar: new AppBar(
//        title: const Text('Basic Hero Animation'),
//      ),
//      body: new Center(
//        child: new PhotoViewer(
//          heroTag: 'images/genji.png',
//          width: 300.0,
//          onTap: () {
//            Navigator.of(context).push(
//                new MaterialPageRoute<Null>(builder: (BuildContext context) {
//              return new Scaffold(
//                appBar: new AppBar(
//                  title: const Text('Flippers Page'),
//                ),
//                body: new Container(
//                  // The blue background emphasizes that it's a new route.
//                  color: Colors.lightBlueAccent,
//                  padding: const EdgeInsets.all(16.0),
//                  alignment: Alignment.topLeft,
//                  child: new PhotoViewer(
//                    heroTag: 'images/genji.png',
//                    width: 100.0,
//                    onTap: () {
//                      Navigator.of(context).pop();
//                    },
//                  ),
//                ),
//              );
//            }));
//          },
//        ),
//      ),
//    );
//  }
//}
