import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:wenmq_first_flickr_flutter_app/base/photo.dart';

class CommonBuilder {
  static List<Widget> buildPhotoCardList(List<Photo> photoList) {
    if (photoList == null || photoList.isEmpty) return <Widget>[];
    return photoList.map(buildImageFromPhoto).toList();
  }

  static Widget buildImageFromPhoto(photo) => new Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(photo.title),
                subtitle: Text('id :' +
                    photo.id +
                    ' owner:' +
                    photo.owner +
                    ' secret:' +
                    photo.secret),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: buildFadeInImage(photo),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  static String createImageUrl(Photo photo) =>
      'https://farm${photo.farm}.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}.jpg';

  static FadeInImage buildFadeInImage(Photo photo) {
    return FadeInImage(
      image: NetworkImage(createImageUrl(photo)),
      fit: BoxFit.fill,
    );
  }

  static Image buildNetworkImage(Photo photo) {
    return Image(
      image: NetworkImage(
        createImageUrl(photo),
      ),
    );
  }

  static WidgetBuilder createWidgetBuilder(dynamic widget) {
    assert(widget is Widget);
    return (BuildContext context) => widget;
  }

  static const Icon iconBack = Icon(Icons.arrow_back_ios);

  static Color getRandomColor() => Color.fromARGB(
        127,
        math.Random().nextInt(255),
        math.Random().nextInt(255),
        math.Random().nextInt(255),
      );
}
