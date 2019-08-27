import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class MFlickrTestApi {
  /// a echo can return a <String,Object> Map, this will parse as a
  /// <String,String> Map
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
  /// flickr.test.testEcho
  ///
  /// A testing method which echo's all parameters back in the response.
  /// [flickr.test.testEcho]
  /// (https://www.flickr.com/services/api/flickr.test.echo.html)
  ///

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
