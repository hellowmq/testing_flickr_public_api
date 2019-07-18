import "dart:collection";
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as app_key;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class FlickrOAuth {
  FlickrOAuth() {
    _generateSignature();
    _getRequestToken();
  }

  Map<String, String> authParamsMap = new SplayTreeMap()
    ..['oauth_nonce'] = '123123'
    ..['oauth_timestamp'] =
        ((new DateTime.now().millisecondsSinceEpoch / 1000).floor()).toString()
    ..['oauth_consumer_key'] = '82c6bf925a8bf9823d980b7a3785d4b3'
    ..['oauth_signature_method'] = 'HMAC-SHA1'
    ..['oauth_version'] = '1.0'
    ..['oauth_callback'] = 'http%3A%2F%2Fwww.example.com'
    ..['request_token'] = '';

  static const String oauthUrl = 'https://www.flickr.com/services/oauth/';

  _generateSignature() {
    String _generateBaseString() {
      const List<String> paramsName = [
        'oauth_nonce',
        'oauth_timestamp',
        'oauth_consumer_key',
        'oauth_signature_method',
        'oauth_version',
        'oauth_callback'
      ];
      String baseString = authParamsMap.keys
          .map((key) {
            if (paramsName.contains(key)) {
              return '$key=${authParamsMap[key]}';
            }
            return '';
          }).
          .toList()
          .join('&');
      return 'GET&${Uri.encodeComponent(oauthUrl + 'request_token')}&${Uri.encodeComponent(baseString)}';
    }

    String _generateKey() =>
        '${app_key.secret}&${authParamsMap['request_token']}';

    try {
      var hmacSha1 = new Hmac(sha1, utf8.encode(_generateKey()));
      print(_generateBaseString());
      var result = hmacSha1.convert(utf8.encode(_generateBaseString())).bytes;
      String signauture = Uri.encodeComponent(base64.encode(result));
      authParamsMap['oauth_signature'] = signauture;
    } catch (e) {
      print(e);
      throw '_generateSignature Error';
    }
  }

//  Getting a Request Token

  _getRequestToken() async {
    String _getRequestTokenUrl() {
      const List<String> paramsName = [
        'oauth_nonce',
        'oauth_timestamp',
        'oauth_consumer_key',
        'oauth_signature_method',
        'oauth_version',
        'oauth_callback',
        'oauth_signature'
      ];

      String baseString = authParamsMap.keys
          .map((key) {
            if (paramsName.contains(key)) {
              return '$key=${authParamsMap[key]}';
            }
          })
          .toList()
          .join('&');
      return oauthUrl + 'request_token?' + baseString;
    }

    Function parseRequestToken = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      authParamsMap.addAll(Uri.splitQueryString(response.body));
      if (authParamsMap['oauth_callback_confirmed'] != 'true') {
        throw Exception('oauth_callback_confirmed == false');
      }
    };
    await MQHttpByUrl.getM(_getRequestTokenUrl(), parseRequestToken);
  }

//  Geting the User Authorization

  _getUserAuthorization() async {
    String _getUserAuthorization() =>
        '${oauthUrl}authorize?oauth_token=${authParamsMap['oauth_token']}';

    Function parseUserAuthorization = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      authParamsMap['user_authorization_callback'] = response.body;
    };

    await MQHttpByUrl.getM(_getUserAuthorization(), parseUserAuthorization);
  }

//  交換要求記錄，以取得存取記錄的權限

  _getAccessToken() async {
    String _getAccessTokenUrl() {
      const List<String> paramsName = [
        'oauth_nonce',
        'oauth_timestamp',
        'verifier',
        'oauth_consumer_key',
        'oauth_signature_method',
        'oauth_version',
        'oauth_token',
        'oauth_signature',
      ];

      String paramsString = authParamsMap.keys
          .map((key) {
            if (paramsName.contains(key)) {
              return '$key=${authParamsMap[key]}';
            }
          })
          .toList()
          .join('&');
      return oauthUrl + 'access_token?' + paramsString;
    }

    Function parseAccessToken = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      print(response.body);
      try {
        authParamsMap.addAll(Uri.splitQueryString(response.body));
      } catch (e) {
        print(e.toString() +
            'authParamsMap.addAll(Uri.splitQueryString(response.body))');
      }
    };
    await MQHttpByUrl.getM(_getAccessTokenUrl(), parseAccessToken);
  }

//  透過 OAuth 呼叫 Flickr API

  callTestFlickrApiWithOAuth() {
    const List<String> paramsName = [
      'oauth_nonce',
      'oauth_timestamp',
      'oauth_consumer_key',
      'oauth_signature_method',
      'oauth_version',
      'oauth_signature',
      'oauth_token',
    ];
    String fullUrl =
        'https://www.flickr.com/services/rest?nojsoncallback=1 &format=json&method=flickr.test.login&' +
            authParamsMap.keys
                .map((key) {
                  if (paramsName.contains(key)) {
                    return '$key=${authParamsMap[key]}';
                  }
                })
                .toList()
                .join('&');

    Function parseTestLogin = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      print(response.body);
      try {
        if (json.decode(response.body)['stat'] != 'ok') {
          throw Exception('stat is not ok');
        }
      } catch (e) {
        print(e.toString());
      }
    };
    MQHttpByUrl.getM(fullUrl, parseTestLogin);
  }
}
