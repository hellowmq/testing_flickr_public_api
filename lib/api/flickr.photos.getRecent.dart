import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:wenmq_first_flickr_flutter_app/base/MQHttpGet.dart';

class GetRecentPhotos {
  GetRecentPhotos();

  Future<List<Widget>> request() async {
    Map<String, String> params = new Map();
    params['method'] = 'flickr.photos.getRecent';
    List<Photo> photoList;
    Function parseResponse = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      photoList = json
          .decode(response.body)['photos']['photo']
          .map<Photo>((json) => Photo.fromJson(json))
          .toList();
    };
    await MQHttpGet.getM(params, parseResponse);
    return _buildPhotoCardList(photoList);
  }

  List<Widget> _buildPhotoCardList(List<Photo> photoList) {
    return photoList
        .map(
          (photo) => new Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new ListTile(
                        title: Text(photo.title),
                        subtitle: Text(
                            photo.id + ' ' + photo.owner + ' ' + photo.secret),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              'https://live.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}.jpg',
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

class Photo {
  final String id;
  final String owner;
  final String secret;
  final String server;
  final int farm;
  final String title;
  final int ispublic;
  final int isfriend;
  final int isfamily;

  Photo(
      {this.id,
      this.owner,
      this.secret,
      this.server,
      this.farm,
      this.title,
      this.ispublic,
      this.isfriend,
      this.isfamily});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      owner: json['owner'],
      secret: json['secret'],
      server: json['server'],
      farm: json['farm'],
      title: json['title'],
      ispublic: json['ispublic'],
      isfriend: json['isfriend'],
      isfamily: json['isfamily'],
    );
  }
}
