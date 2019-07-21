import "dart:collection";
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as app_key;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

// 请务必在每次需要传递 signature 时更新 signature（使用 HMAC-SHA1 加密）
class FlickrOAuth {
  static const String oauthUrl = 'https://www.flickr.com/services/oauth/';
  Map<String, String> authParamsMap = new SplayTreeMap()
    ..['oauth_nonce'] = '123456'
    ..['oauth_timestamp'] =
        ((new DateTime.now().millisecondsSinceEpoch / 1000).floor()).toString()
    ..['oauth_consumer_key'] = '82c6bf925a8bf9823d980b7a3785d4b3'
    ..['oauth_signature_method'] = 'HMAC-SHA1'
    ..['oauth_version'] = '1.0'
    ..['oauth_callback'] = 'https%3A%2F%2Fwww.example.com'
    ..['oauth_token_secret'] = ''
    ..['flutter_string'] = 'flutter_string';

//  簽署要求
  String generateSignature(
      {String pathOauth = 'request_token', String requestMethod = 'GET'}) {
    String _generateBaseString() {
      const List<String> paramsNames = [
        'oauth_nonce',
        'oauth_timestamp',
        'oauth_consumer_key',
        'oauth_signature_method',
        'oauth_version',
        'oauth_callback'
      ];
      String requestUrlString = Uri.encodeComponent(oauthUrl + pathOauth);
      String paramsString = Uri.encodeComponent(authParamsMap.keys
          .where((key) => paramsNames.contains(key))
          .map((key) => '$key=${authParamsMap[key]}')
          .toList()
          .join('&'));
      return '$requestMethod&$requestUrlString&$paramsString';
    }

    String _generateKey() =>
        '${app_key.secret}&${authParamsMap['oauth_token_secret']}';

    try {
      var hmacSha1 = new Hmac(sha1, utf8.encode(_generateKey()));
      print(_generateBaseString());
      String signature = Uri.encodeComponent(base64
          .encode(hmacSha1.convert(utf8.encode(_generateBaseString())).bytes));
      authParamsMap['oauth_signature'] = signature;
      print('FlickrOAuth.generateSignature = $signature');
      return signature;
    } catch (e) {
      print(e);
      throw FormatException('Generate Signature Error');
    }
  }

//  取得要求記錄
  Future<String> requestToken() async {
    String _generateRequestTokenUrl() {
      const List<String> paramsNames = [
        'oauth_nonce',
        'oauth_timestamp',
        'oauth_consumer_key',
        'oauth_signature_method',
        'oauth_version',
        'oauth_signature',
        'oauth_callback'
      ];

      String paramsString = authParamsMap.keys
          .where((key) => paramsNames.contains(key))
          .map((key) => '$key=${authParamsMap[key]}')
          .toList()
          .join('&');
      return '${oauthUrl}request_token?$paramsString';
    }

    parseRequestToken(value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw Exception("value == null");
        }
      } catch (e) {
        print('requestToken.parseRequestToken' + e.toString());
      }
      authParamsMap.addAll(Uri.splitQueryString(response.body));
      generateSignature(pathOauth: 'access_token', requestMethod: 'POST');
      if (authParamsMap['oauth_callback_confirmed'] != 'true') {
        throw Exception('oauth_callback_confirmed == false');
      }
    }

    await MQHttpByUrl.getM(_generateRequestTokenUrl(), parseRequestToken);

    return 'true';
  }

//  取得使用者授權
  Future<String> authorize() async {
    String generateAuthorizeUrl() {
      return '${oauthUrl}authorize?oauth_token=${authParamsMap['oauth_token']}';
    }

    parseAuthorizeResult(value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw Exception("value == null");
        }
      } catch (e) {
        print(e.toString());
      }
      Uri.decodeComponent(response.body);
      authParamsMap.addAll(Uri.splitQueryString(response.body));
      if (!authParamsMap.containsKey('oauth_verifier')) {
        throw Exception(
            'FlickrOAuth.Authorize authParamsMap["oauth_verifier"] == null');
      }
    }

//    await MQHttpByUrl.getM(_generateAuthorizeUrl(), parseAuthorizeResult);
    return authParamsMap['FlickrOAuth'];
  }

//  交換要求記錄，以取得存取記錄的權限
  Future<String> accessToken() async {
    String _generateAccessTokenUrl() {
      const List<String> paramsNames = [
        'oauth_nonce',
        'oauth_timestamp',
        'oauth_verifier',
        'oauth_consumer_key',
        'oauth_signature_method',
        'oauth_version',
        'oauth_token',
        'oauth_signature'
      ];
      String paramsString = authParamsMap.keys
          .where((key) => paramsNames.contains(key))
          .map((key) => '$key=${authParamsMap[key]}')
          .toList()
          .join('&');
      return '${oauthUrl}access_token?$paramsString';
    }

    parseAccessToken(value) {
      final response = value as http.Response;
      try {
        print(response.body);
        if (response == null) {
          throw Exception("value == null");
        }
      } catch (e) {
        print('accessToken.parseAccessToken' + e.toString());
      }
      authParamsMap.addAll(Uri.splitQueryString(response.body));
      if (!authParamsMap.containsKey('oauth_token_secret')) {
        throw Exception(
            'FlickrOAuth.Authorize authParamsMap["oauth_token_secret"] == null');
      }
    }

    await MQHttpByUrl.getM(_generateAccessTokenUrl(), parseAccessToken);
    return authParamsMap['oauth_token_secret'];
  }

//  透過 OAuth 呼叫 Flickr API
  Future<String> testLogin() async {
    String _generateTestLoginUrl() {
      String url =
          'https://www.flickr.com/services/rest?nojsoncallback=1 &format=json&method=flickr.test.login&';
      const List<String> paramsNames = [
        'oauth_nonce',
        'oauth_timestamp',
        'oauth_verifier',
        'oauth_consumer_key',
        'oauth_signature_method',
        'oauth_version',
        'oauth_signature',
        'oauth_token'
      ];
      String paramsString = paramsNames
          .where((key) => paramsNames.contains(key))
          .map((key) => '$key=${authParamsMap[key]}')
          .toList()
          .join('&');
      return url + paramsString;
    }

    String userInfo = '';
    parseTestLogin(value) {
      final response = value as http.Response;
      try {
        print(response.body);
        if (response == null) {
          throw Exception("value == null");
        }
      } catch (e) {
        print('testLogin.parseTestLogin()' + e.toString());
      }
      print(response.body);
      userInfo = response.body;
    }

    await MQHttpByUrl.getM(_generateTestLoginUrl(), parseTestLogin);
    return userInfo;
  }
}
