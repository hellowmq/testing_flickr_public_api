import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as key;
import 'unique_typedef.dart';
import 'string.dart';

///
/// @Author hellowmq
/// @Date 2019-8-24
/// This common rest of flickr api
///
///

const Map<String, String> pubArguments = {
  QueryKeyConstant.FORMAT: QueryValueConstant.JSON,
  QueryKeyConstant.NO_JSON_CALLBACK: QueryValueConstant.VALUE_NO_JSON_CALLBACK,
  QueryKeyConstant.API_KEY: key.apiKey
};

/// init commit of http get standard
class MQHttpRestGet {
  static const String TAG = "MQHttpRestGet";

  static getM(Map<String, dynamic> params, Function callback) async {
    String fullUri = FlickrConstant.FLICKR_HOST + FlickrConstant.FLICKR_REST_PATH + '?';
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

  static restGetM<T>(
      Map<String, dynamic> params, MQSuccessCallback<T> callback) async {
    String fullUri = FlickrConstant.FLICKR_HOST + FlickrConstant.FLICKR_REST_PATH + '?';
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
  final String TAG = "MRestGet";

  static MRestGet _instance;

  static MRestGet get instance => _getInstance();

  factory MRestGet() => _getInstance();

  static MRestGet _getInstance() {
    if (_instance == null) {
      _instance = MRestGet._internal();
    }
    return _instance;
  }

  MRestGet._internal() {
    print(new DateTime.now());
  }

  factory MRestGet.getInstance() {
    if (_instance == null) {
      _instance = MRestGet();
    }
    return _instance;
  }

  void getAnotherM(Map<String, dynamic> params,
      {MQSuccessCallback onSuccess, ErrorCallback onError}) async {
    String fullUri = FlickrConstant.FLICKR_HOST + FlickrConstant.FLICKR_REST_PATH + '?';
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
