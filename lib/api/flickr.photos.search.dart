import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

///
/// @Author hellowmq
/// @Date 2019-8-24
/// This is a api helper class of flickr.photos.search.
///
///
class SearchPhotos {
  SearchPhotos();

  Future<List<Photo>> request(
      {Map<String, String> additionalParams = const {}}) async {
    Map<String, String> params = new Map();
    params[QueryKeyConstant.METHOD] = FlickrConstant.FLICKR_PHOTOS_SEARCH;
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
          .decode(response.body)[FlickrConstant.PHOTOS][FlickrConstant.PHOTO]
          .map<Photo>((json) => Photo.fromJson(json))
          .toList();
    };
    await MQHttpRestGet.getM(params, parseResponse);
    return photoList;
  }
}
