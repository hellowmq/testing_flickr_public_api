import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

///
/// @Author hellowmq
/// @Date 2019-8-24
/// This is a api helper class of flickr.test.echo.
///

// {
//    "method": {
//        "_content": "flickr.test.echo"
//    },
//    "api_key": {
//        "_content": "28b8ea4d523ed0bc1ce264306327c4c3"
//    },
//    "format": {
//        "_content": "json"
//    },
//    "nojsoncallback": {
//        "_content": "1"
//    },
//    "name": {
//        "_content": "123"
//    },
//    "stat": "ok"
//}
class EchoTest {

  EchoTest();

  Future<String> request(String echoText) async {
    Map<String, String> params = new Map();
    params['method'] = 'flickr.test.echo';
    params['name'] = echoText;
    String text;
    Function parseResponse = (value) {
      final response = value as http.Response;
      print(json.decode(response.body));
      final name = json.decode(response.body)['name']['_content'];
      try {
        if (name == null) {
          throw 'name == null';
        }
      } catch (e) {
        print(e.toString());
      }
      print('get Echo from flickr.test.echo: ${response.body}');
      text = name;
    };
    await MQHttpRestGet.getM(params, parseResponse);
    return text;
  }
}
