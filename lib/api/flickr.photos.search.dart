import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class SearchPhotos {
  SearchPhotos();

  Future<List<Photo>> request(
      {Map<String, String> additionalParams = const {}}) async {
    Map<String, String> params = new Map();
    params['method'] = 'flickr.photos.search';
    if (additionalParams != null) {
      params.addAll(additionalParams);
    }
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
    await MQHttpRestGet.getM(params, parseResponse);
    return photoList;
  }

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
                        subtitle: Text(
                            photo.id + ' ' + photo.owner + ' ' + photo.secret),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              'https://farm${photo.farm}.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}.jpg',
                          fit: BoxFit.fill,
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
