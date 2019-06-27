import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as key;

class MQHttpGet {
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
    var response;
    try {
      response = await http.get(fullUri);
    } catch (e) {
      print('Error: Connection Error');
    }
    try {
      Function.apply(callback, [response]);
    } catch (e) {
      print('callback function throw exception');
    }
  }
}
