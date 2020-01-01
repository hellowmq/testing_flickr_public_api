import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'dart:math' as math;
import 'package:wenmq_first_flickr_flutter_app/base/bean/photo.dart';

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
                subtitle: Text(photo.toString()),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: buildHeroImage(photo),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  static Widget buildHeroImage(Photo photo) {
    return new PhotoViewWithBasePage(
      buildFadeInImage(photo),
      photo.hashCode.toString(),
      photoUrl: photo.imgUrl,
    );
  }

  static FadeInImage buildFadeInImage(Photo photo) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: photo.imgUrl,
      fit: BoxFit.fill,
    );
  }

  static Image buildNetworkImage(Photo photo) {
    return new Image.network(photo.imgUrl);
  }

  static WidgetBuilder createWidgetBuilder(dynamic widget) {
    assert(widget is Widget);
    return (BuildContext context) => widget;
  }

  static const Icon iconBack = Icon(Icons.arrow_back_ios);

  static Color getRandomColor() => Color.fromARGB(
        255,
        math.Random().nextInt(255),
        math.Random().nextInt(255),
        math.Random().nextInt(255),
      );
}
