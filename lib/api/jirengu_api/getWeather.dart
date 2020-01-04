import 'package:wenmq_first_flickr_flutter_app/api/jirengu_api/jirengu_api.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetWeather {
  static const String UrlWeatherOfCity =
      'http://api.jirengu.com/getWeather.php';

  static void getWeather(void Function(WeatherBean bean) onParseWeather,
      ErrorCallback errorCallback) {
    getAnotherM(UrlWeatherOfCity,
        onSuccess: (http.Response re) => onParseWeather(parseWeather(re)),
        onError: (e, re) {
          if (errorCallback != null) {
            errorCallback(e, re);
          }
          MQLogger.debugPrint(e);
        });
  }

  static parseWeather(http.Response response) {
    var decodedString = utf8.decode(response.bodyBytes);
    return WeatherBean.fromJson(json.decode(decodedString));
  }

  static void getAnotherM(String fullUrl,
      {MQSuccessCallback onSuccess, ErrorCallback onError}) async {
    http.Response response;
    try {
      response = await http.get(fullUrl);
      if (response == null || response.statusCode != 200) {
        throw Exception('Connection Error: ${response.statusCode}');
      } else if (json.decode(response.body)['status'] != 'success') {
        throw Exception('jirengu Api Error: ' + response.body);
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
      MQLogger.debugPrint('Connection Error: $exception');
    }
  }
}
