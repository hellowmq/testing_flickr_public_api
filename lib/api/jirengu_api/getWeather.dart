import 'package:wenmq_first_flickr_flutter_app/api/jirengu_api/jirengu_api.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetWeather {
  static const String UrlWeatherOfCity =
      'http://api.jirengu.com/getWeather.php';

  static void getWeather() {
    getAnotherM(UrlWeatherOfCity, onSuccess: parseWeather, onError: (e, re) {});
  }

  static parseWeather(http.Response response) {
    return WeatherBean.fromJson(json.decode(response.body));
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
