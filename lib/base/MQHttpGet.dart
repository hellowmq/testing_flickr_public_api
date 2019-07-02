import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as key;

class MQHttpRestGet {
  static const String uri = 'https://www.flickr.com/services/rest/';
  static const Map<String, String> requestSettings = {
    'format': 'json',
    'nojsoncallback': '1',
    'api_key': key.apiKey
  };

  static getM(Map<String, dynamic> params, Function callback) async {
    String fullUri = uri + '?';
    params.forEach((key, value) {
      fullUri += "$key=" + value + "&";
    });
    requestSettings.forEach((key, value) {
      fullUri += "$key=" + value + "&";
    });

    print(fullUri);
    http.Response response;
    try {
      response = await http.get(fullUri);

      if (response == null || response.statusCode != 200) {
        throw Exception('Connection Error: ${response.statusCode}');
      }
      if (json.decode(response.body)['stat'] != 'ok') {
        throw Exception('Flickr Api Error: ' + response.body);
      }
      try {
        Function.apply(callback, [response]);
      } catch (callbackError) {
        throw Exception('Callback Function Error: $callbackError');
      }
    } catch (e) {
      print('Connection Error: $e');
      rethrow;
    }
  }
}
