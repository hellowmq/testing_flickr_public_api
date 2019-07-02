import 'package:http/http.dart' as http;

class MQHttpOAuthGet {
  static const String uri =
      'https://www.flickr.com/services/oauth/request_token?';

  static getM(String url, Function callback) async {
    http.Response response;
    try {
      print(url);
      response = await http.get(url);
      if (response == null) {
        throw Exception('Connection Error: ${response.statusCode}');
      }
      try {
        Function.apply(callback, [response]);
      } catch (callbackError) {
        throw Exception('Callback Function Error: $callbackError');
      }
    } catch (e) {
      print('Connection Error : $e');
      rethrow;
    }
  }
}
