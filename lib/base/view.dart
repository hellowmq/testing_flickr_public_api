import 'package:flutter/material.dart';
import 'photo.dart';
import 'package:transparent_image/transparent_image.dart';

class ViewBuilder {
  static List<Widget> buildPhotoCardList(List<Photo> photoList) {
    if (photoList == null || photoList.isEmpty) return <Widget>[];
    return photoList
        .map(
          (photo) => new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: new Card(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: Text(photo.title),
                    subtitle:
                        Text(photo.id + ' ' + photo.owner + ' ' + photo.secret),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(5.0),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          'https://farm${photo.farm}.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}.jpg',
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}
