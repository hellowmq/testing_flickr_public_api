import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as key;

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



/// init commit of http get standard
class MQHttpRestGet {
  static const String TAG = "MQHttpRestGet";

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
        throw Exception('$TAG Connection Error: ${response.statusCode}');
      } else if (json.decode(response.body)['stat'] != 'ok') {
        throw Exception('$TAG Flickr Api Error: ' + response.body);
      } else {
        try {
          Function.apply(callback, [response]);
        } catch (callbackError) {
          throw Exception('$TAG Callback Function Error: $callbackError');
        }
      }
    } catch (e) {
      print('$TAG Connection Error: $e');
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

class MRestGet {
  static const String TAG = "MRestGet";

  MRestGet();

  static MRestGet _instance;

  factory MRestGet.getInstance() {
    if (_instance != null) {
      _instance = MRestGet();
    }
    return _instance;
  }

  getM(Map<String, dynamic> params, MQSuccessCallback callback) async {
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

  void getAnotherM(Map<String, dynamic> params,
      {MQSuccessCallback onSuccess, MQErrorCallback onError}) async {
    String fullUri = HOST_REST + '?';
    params.forEach((key, value) => fullUri += "$key=$value&");
    pubArguments.forEach((key, value) => fullUri += "$key=$value&");
    http.Response response;
    try {
      response = await http.get(fullUri);
      if (response == null || response.statusCode != 200) {
        throw Exception('Connection Error: ${response.statusCode}');
      } else if (json.decode(response.body)['stat'] != 'ok') {
        throw Exception('Flickr Api Error: ' + response.body);
      } else {
        try {
          if (onSuccess != null) {
            onSuccess(response);
          } else {
            throw Exception('onSuccess callback is null');
          }
        } catch (callbackError) {
          throw Exception('Callback Function Error: $callbackError');
        }
      }
    } catch (exception) {
      if (onError != null) {
        onError(exception, response);
      }
      print('Connection Error: $exception');
    }
  }
}
