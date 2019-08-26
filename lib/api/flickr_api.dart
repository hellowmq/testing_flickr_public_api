import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

typedef PhotoListCallback = void Function(List<Photo>);
typedef MapContentCallback = void Function(Map<String, String>);
typedef ErrorCallCallback = void Function(Exception, http.Response);
/// Create [MFlickrApi] to request a flickr-api request.
class MFlickrApi {
  ///  parse json as {List<Photo>}
  List<Photo> parseStringAsPhotoList(String data) {
    try {
      return json
          .decode(data)['photos']['photo']
          .map<Photo>((json) => Photo.fromJson(json))
          .toList();
    } catch (exception) {
      print(exception);
      return List<Photo>();
    }
  }

  /// a echo can return a <String,Object> Map, this will parse as a <String,String> Map
  Map<String, String> parseStringAsMap(String data) {
    return (json.decode(data) as Map).map(
      (key, value) => MapEntry(
          key,
          ((value is Map) && (value.containsKey('_content')))
              ? value['_content']
              : value),
    );
  }
  ///
  /// flickr.photos.getRecent
  /// [https://www.flickr.com/services/api/flickr.photos.getRecent.html](https://www.flickr.com/services/api/flickr.photos.getRecent.html)
  ///
  void getRecent(
      {Map<String, dynamic> params,
      PhotoListCallback onSuccess,
      ErrorCallCallback onError}) {
    MRestGet.getInstance().getAnotherM(
      (params ?? new Map<String, dynamic>())
        ..['method'] = 'flickr.photos.getRecent',
      onSuccess: (http.Response response) =>
          onSuccess(parseStringAsPhotoList(response.body)),
      onError: onError,
    );
  }

  void getPopular(
      {Map<String, dynamic> params,
      PhotoListCallback onSuccess,
      ErrorCallCallback onError}) {
    MRestGet.getInstance().getAnotherM(
      (params ?? new Map<String, dynamic>())
        ..['method'] = 'flickr.photos.getPopular',
      onSuccess: (http.Response response) =>
          onSuccess(parseStringAsPhotoList(response.body)),
      onError: onError,
    );
  }

  void searchPhotos(
      {Map<String, dynamic> params,
      PhotoListCallback onSuccess,
      ErrorCallCallback onError}) {
    MRestGet.getInstance().getAnotherM(
        (params ?? new Map<String, dynamic>())
          ..['method'] = 'flickr.photos.getPopular',
        onSuccess: (http.Response response) =>
            onSuccess(parseStringAsPhotoList(response.body)),
        onError: onError);
  }

  void testEcho(
      {Map<String, dynamic> params,
      MapContentCallback onSuccess,
      ErrorCallCallback onError}) {
    MRestGet.getInstance().getAnotherM(
      (params ?? new Map<String, dynamic>())..['method'] = 'flickr.test.echo',
      onSuccess: (http.Response response) =>
          onSuccess(parseStringAsMap(response.body)),
      onError: onError,
    );
  }
}
