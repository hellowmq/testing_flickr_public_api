import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

/// Create [MFlickrPhotoApi] to request a flickr-api request.
class MFlickrPhotoApi {
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

  /// Actually, all other method are the same except the method name.
  void getPhotoList(String methodName,
      {Map<String, dynamic> params,
      PhotoListCallback onSuccess,
      ErrorCallCallback onError}) {
    MRestGet.getInstance().getAnotherM(
      (params ?? new Map<String, dynamic>())..['method'] = methodName,
      onSuccess: (http.Response response) =>
          onSuccess(parseStringAsPhotoList(response.body)),
      onError: onError,
    );
  }

  ///
  /// flickr.photos.getRecent
  ///
  /// Returns a list of the latest public photos uploaded to flickr.
  /// [flickr.photos.getRecent]
  /// (https://www.flickr.com/services/api/flickr.photos.getRecent.html)
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

  ///
  /// flickr.photos.getPopular
  ///
  /// Returns a list of popular photos
  /// [flickr.photos.getPopular]
  /// (https://www.flickr.com/services/api/flickr.photos.getPopular.html)
  ///

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

  ///
  /// flickr.photos.search
  ///
  /// Return a list of photos matching some criteria. Only photos visible to the
  /// calling user will be returned. To return private or semi-private photos,
  /// the caller must be authenticated with 'read' permissions, and have
  /// permission to view the photos. Unauthenticated calls will only return
  /// public photos.
  /// [flickr.photos.search]
  /// (https://www.flickr.com/services/api/flickr.photos.search.html)
  ///

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
}
