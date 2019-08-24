import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as key;

///
/// @Author hellowmq
/// @Date 2019-8-24
/// This common rest of flickr api
///
/// 

class MQHttpRestGet {
  static const String HOST = 'https://www.flickr.com/';
  static const String HOST_REST = HOST + 'services/rest/';
  static const Map<String, String> pubArguments = {
    'format': 'json',
    'nojsoncallback': '1',
    'api_key': key.apiKey
  };

  static getM(Map<String, dynamic> params, Function callback) async {
    String fullUri = HOST_REST + '?';
    params.forEach((key, value) {
      fullUri += "$key=" + value + "&";
    });
    pubArguments.forEach((key, value) {
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

  static getMSigned() {


  }
}
