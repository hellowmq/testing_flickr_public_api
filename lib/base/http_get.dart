import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as key;
import 'dart:async';

///
/// @Author hellowmq
/// @Date 2019-8-24
/// This common rest of flickr api
///
///
typedef MQSuccessCallback<T> = T Function(http.Response);
typedef MQErrorCallback = Function(Exception, http.Response);

const String HOST = 'https://www.flickr.com/';
const String HOST_REST = HOST + 'services/rest/';
const Map<String, String> pubArguments = {
  'format': 'json',
  'nojsoncallback': '1',
  'api_key': key.apiKey
};

class MQHttpRestGet {
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

  static getMSigned() {}

  static restGetM<T>(
      Map<String, dynamic> params, MQSuccessCallback<T> callback) async {
    String fullUri = HOST_REST + '?';
    params.forEach((key, value) => fullUri += "$key=$value&");
    pubArguments.forEach((key, value) => fullUri += "$key=$value&");
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

class MRestGet<T> {
  getM<T>(Map<String, dynamic> params, MQSuccessCallback<T> callback) async {
    String fullUri = HOST_REST + '?';
    params.forEach((key, value) => fullUri += "$key=$value&");
    pubArguments.forEach((key, value) => fullUri += "$key=$value&");
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

  getAnotherM<T>(Map<String, dynamic> params,
      {MQSuccessCallback<T> onSuccess, MQErrorCallback onError}) async {
    String fullUri = HOST_REST + '?';
    params.forEach((key, value) => fullUri += "$key=$value&");
    pubArguments.forEach((key, value) => fullUri += "$key=$value&");
    http.Response response;
    T result;
    try {
      response = await http.get(fullUri);
      if (response == null || response.statusCode != 200) {
        throw Exception('Connection Error: ${response.statusCode}');
      }
      if (json.decode(response.body)['stat'] != 'ok') {
        throw Exception('Flickr Api Error: ' + response.body);
      }
      try {
        if (onSuccess != null) {
          result = onSuccess(response);
        }
      } catch (callbackError) {
        throw Exception('Callback Function Error: $callbackError');
      }
    } catch (e) {
      if (onError != null) {
        onError(e, response);
      }
      print('Connection Error: $e');
      rethrow;
    }
  }
}
