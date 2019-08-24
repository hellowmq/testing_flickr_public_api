import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
///
/// @Author hellowmq
/// @Date 2019-8-24
/// This is a api helper class of flickr.photos.getPopular.
///
///


class GetPopularPhotos {
  GetPopularPhotos();

  Future<List<Photo>> request(
      {Map<String, String> additionalParams = const {}}) async {
    Map<String, String> params = new Map();
    params['method'] = 'flickr.photos.getPopular';
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
}
