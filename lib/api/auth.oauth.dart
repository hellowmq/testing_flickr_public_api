import "dart:collection";
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as app_key;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

// 请务必在每次需要传递 signature 时更新 signature（使用 HMAC-SHA1 加密）
class FlickrOAuth {
//  Use FlickrOAuth.getinstance() to get a FlickrOAuth Object
  static FlickrOAuth _instance;
  static const String FLICKR_HOST_URL = 'https://www.flickr.com';
  static const String FLICKR_OAUTH_URL =
      'https://www.flickr.com/services/oauth/';
//  Keep all the variables of the OAuth process.
  Map<String, String> authParamsMap = new SplayTreeMap()
    ..['oauth_nonce'] = '123456'
    ..['oauth_timestamp'] =
        ((new DateTime.now().millisecondsSinceEpoch / 1000).floor()).toString()
    ..['oauth_consumer_key'] = app_key.apiKey
    ..['oauth_signature_method'] = 'HMAC-SHA1'
    ..['oauth_version'] = '1.0'
    ..['oauth_callback'] = 'https%3A%2F%2Fwww.example.com'
    ..['oauth_token_secret'] = '';

//  Get A FLickrOAuth Object. if null create one.
  static FlickrOAuth getInstance() {
    if (_instance == null) {
      _instance = new FlickrOAuth();
      _instance.authParamsMap = new SplayTreeMap()
        ..['oauth_nonce'] = '123456'
        ..['oauth_timestamp'] =
            ((new DateTime.now().millisecondsSinceEpoch / 1000).floor())
                .toString()
        ..['oauth_consumer_key'] = app_key.apiKey
        ..['oauth_signature_method'] = 'HMAC-SHA1'
        ..['oauth_version'] = '1.0'
        ..['oauth_callback'] = 'https%3A%2F%2Fwww.example.com'
        ..['oauth_token_secret'] = '';
    }
    return _instance;
  }

  static String _getSignature(
      {String httpVerb = 'GET',
      String requestUrl = '/services/oauth/request_token',
      SplayTreeMap<String, String> params,
      String tokenSecret}) {
    assert(httpVerb != null);
    assert(requestUrl != null);
    assert(params != null);
    assert(tokenSecret != null);

    String _generateBaseString() {
      String requestUrlString =
          Uri.encodeComponent(FLICKR_OAUTH_URL + requestUrl);
      String paramsString = Uri.encodeComponent(
          params.keys.map((key) => '$key=${params[key]}').toList().join('&'));
      return '$httpVerb&$requestUrlString&$paramsString';
    }

    String _generateKey() => '${app_key.secret}&$tokenSecret';
    try {
      var hmacSha1 = new Hmac(sha1, utf8.encode(_generateKey()));
      print(_generateBaseString());
      String signature = Uri.encodeComponent(base64
          .encode(hmacSha1.convert(utf8.encode(_generateBaseString())).bytes));
      return signature;
    } catch (e) {
      print(e);
      throw FormatException('Generate Signature Error');
    }
  }

  Future<String> requestToken() async {
    void _generateSignature() {
      SplayTreeMap<String, String> params = new SplayTreeMap()
        ..['oauth_nonce'] = authParamsMap['oauth_nonce']
        ..['oauth_timestamp'] = authParamsMap['oauth_timestamp']
        ..['oauth_consumer_key'] = authParamsMap['oauth_consumer_key']
        ..['oauth_signature_method'] = authParamsMap['oauth_signature_method']
        ..['oauth_version'] = authParamsMap['oauth_version']
        ..['oauth_callback'] = authParamsMap['oauth_callback'];
      String tokenSecret = authParamsMap['oauth_token_secret'];
      authParamsMap['oauth_signature'] = FlickrOAuth._getSignature(
          httpVerb: 'GET',
          requestUrl: '/services/oauth/request_token',
          params: params,
          tokenSecret: tokenSecret);
    }

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
      return '${FLICKR_OAUTH_URL}request_token?$paramsString';
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
      if (authParamsMap['oauth_callback_confirmed'] != 'true') {
        throw Exception('oauth_callback_confirmed == false');
      }
    }

    _generateSignature();

    await MQHttpByUrl.getM(_generateRequestTokenUrl(), parseRequestToken);

    return 'true';
  }

//  取得使用者授權
  Future<String> authorize() async {
    String generateAuthorizeUrl() {
      return '${FLICKR_OAUTH_URL}authorize?oauth_token=${authParamsMap['oauth_token']}';
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

    if (authParamsMap.containsKey('oauth_token') &&
        authParamsMap['oauth_token'].isNotEmpty) {
      return authParamsMap['FlickrOAuth'];
    }
//    await MQHttpByUrl.getM(_generateAuthorizeUrl(), parseAuthorizeResult);
    throw Exception('authParamsMap["oauth_token"].isEmpty');
  }

//  交換要求記錄，以取得存取記錄的權限
  Future<String> accessToken() async {
    void _generateSignature() {
      SplayTreeMap<String, String> params = new SplayTreeMap()
        ..['oauth_nonce'] = authParamsMap['oauth_nonce']
        ..['oauth_timestamp'] = authParamsMap['oauth_timestamp']
        ..['oauth_verifier'] = authParamsMap['oauth_verifier']
        ..['oauth_consumer_key'] = authParamsMap['oauth_consumer_key']
        ..['oauth_signature_method'] = authParamsMap['oauth_signature_method']
        ..['oauth_version'] = authParamsMap['oauth_version']
        ..['oauth_token'] = authParamsMap['oauth_token'];
      String tokenSecret = authParamsMap['oauth_token_secret'];
      authParamsMap['oauth_signature'] = FlickrOAuth._getSignature(
          httpVerb: 'GET',
          requestUrl: '/services/oauth/access_token',
          params: params,
          tokenSecret: tokenSecret);
    }

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
      return '${FLICKR_OAUTH_URL}access_token?$paramsString';
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

    _generateSignature();
    await MQHttpByUrl.getM(_generateAccessTokenUrl(), parseAccessToken);
    return authParamsMap['oauth_token_secret'];
  }

//  透過 OAuth 呼叫 Flickr API
  Future<String> testLogin() async {
    void _generateSignature() {
      SplayTreeMap<String, String> params = new SplayTreeMap()
        ..['format'] = authParamsMap['json']
        ..['oauth_consumer_key'] = authParamsMap['oauth_consumer_key']
        ..['oauth_timestamp'] = authParamsMap['oauth_timestamp']
        ..['oauth_signature_method'] = authParamsMap['oauth_signature_method']
        ..['oauth_version'] = authParamsMap['oauth_version']
        ..['oauth_token'] = authParamsMap['oauth_token']
        ..['method'] = authParamsMap['flickr.test.login'];
      String tokenSecret = authParamsMap['oauth_token_secret'];
      authParamsMap['oauth_signature'] = FlickrOAuth._getSignature(
          httpVerb: 'GET',
          requestUrl: '/services/rest',
          params: params,
          tokenSecret: tokenSecret);
    }

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

    _generateSignature();
    await MQHttpByUrl.getM(_generateTestLoginUrl(), parseTestLogin);
    print(userInfo);
    return userInfo;
  }
}
