import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/base/MQHttpGet.dart';

class GetRecentPhotos {
  GetRecentPhotos();

  Future<String> request() async {
    Map<String, String> params = new Map();
    params['method'] = 'flickr.photos.getRecent';
    String text;
    Function parseResponse = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      text = response.body;
    };
    await MQHttpGet.getM(params, parseResponse);
    return text;
  }
}
