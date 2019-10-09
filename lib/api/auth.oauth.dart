import "dart:collection";
import 'dart:convert';
import 'dart:math';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as app_key;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

///
/// Author hellowmq
/// This is an example of oauth of Flickr API. It is highly integrated
/// with page page content now. it will be refactor lately.
///
///
// 请务必在每次需要传递 signature 时更新 signature（使用 HMAC-SHA1 加密）
class FlickrOAuth {
//  Use FlickrOAuth.getinstance() to get a FlickrOAuth Object
  static FlickrOAuth _instance;
  static const String FLICKR_HOST_URL = FlickrConstant.FLICKR_HOST;

//  static const String FLICKR_OAUTH_URL = FlickrConstant.FLICKR_OAUTH_URL;

  static const String HMAC_SHA1 = QueryValueConstant.HMAC_SHA1;
  static const String VALUE_OAUTH_VERSION =
      QueryValueConstant.VALUE_OAUTH_VERSION;
  static const String FORMAT = QueryKeyConstant.FORMAT;
  static const String METHOD = QueryKeyConstant.METHOD;
  static const String JSON = QueryValueConstant.JSON;

  static const String NOJSONCALLBACK = QueryKeyConstant.NO_JSON_CALLBACK;
  static const String OAUTH_CALLBACK = QueryKeyConstant.OAUTH_CALLBACK;
  static const String OAUTH_CALLBACK_CONFIRMED =
      QueryKeyConstant.OAUTH_CALLBACK_CONFIRMED;
  static const String OAUTH_CONSUMER_KEY = QueryKeyConstant.OAUTH_CONSUMER_KEY;
  static const String OAUTH_NONCE = QueryKeyConstant.OAUTH_NONCE;
  static const String OAUTH_SIGNATURE = QueryKeyConstant.OAUTH_SIGNATURE;
  static const String OAUTH_SIGNATURE_METHOD =
      QueryKeyConstant.OAUTH_SIGNATURE_METHOD;
  static const String OAUTH_TIMESTAMP = QueryKeyConstant.OAUTH_TIMESTAMP;
  static const String OAUTH_TOKEN = QueryKeyConstant.OAUTH_TOKEN;
  static const String OAUTH_TOKEN_SECRET = QueryKeyConstant.OAUTH_TOKEN_SECRET;
  static const String OAUTH_VERIFIER = QueryKeyConstant.OAUTH_VERIFIER;
  static const String OAUTH_VERSION = QueryKeyConstant.OAUTH_VERSION;

//  Keep all the variables of the OAuth process.
  SplayTreeMap<String, String> authParamsMap = new SplayTreeMap()
    ..[OAUTH_NONCE] = Random().nextInt(2147483647).toString()
    ..[OAUTH_TIMESTAMP] =
        ((new DateTime.now().millisecondsSinceEpoch / 1000).floor()).toString()
    ..[OAUTH_CONSUMER_KEY] = app_key.apiKey
    ..[OAUTH_SIGNATURE_METHOD] = HMAC_SHA1
    ..[OAUTH_VERSION] = VALUE_OAUTH_VERSION
    ..[OAUTH_CALLBACK] = 'https%3A%2F%2Fhellowmq.github.io'
    ..[OAUTH_TOKEN_SECRET] = '';

//  Get A FlickrOAuth Object. if null create one.
  static FlickrOAuth getInstance() {
    if (_instance == null) {
      _instance = new FlickrOAuth();
      _instance.authParamsMap = new SplayTreeMap()
        ..[OAUTH_NONCE] = Random().nextInt(2147483647).toString()
        ..[OAUTH_TIMESTAMP] =
            ((new DateTime.now().millisecondsSinceEpoch / 1000).floor())
                .toString()
        ..[OAUTH_CONSUMER_KEY] = app_key.apiKey
        ..[OAUTH_SIGNATURE_METHOD] = HMAC_SHA1
        ..[OAUTH_VERSION] = VALUE_OAUTH_VERSION
        ..[OAUTH_CALLBACK] = 'https%3A%2F%2Fhellowmq.github.io'
        ..[OAUTH_TOKEN_SECRET] = '';
    }
    return _instance;
  }

  FlickrOAuth();

  FlickrOAuth updateInstance() {
    _instance = new FlickrOAuth();
//    var rng = new Random().nextInt(2147483647).toString();
    _instance.authParamsMap = new SplayTreeMap()
      ..[OAUTH_NONCE] = Random().nextInt(2147483647).toString()
      ..[OAUTH_TIMESTAMP] =
          ((new DateTime.now().millisecondsSinceEpoch / 1000).floor())
              .toString()
      ..[OAUTH_CONSUMER_KEY] = app_key.apiKey
      ..[OAUTH_SIGNATURE_METHOD] = HMAC_SHA1
      ..[OAUTH_VERSION] = VALUE_OAUTH_VERSION
      ..[OAUTH_CALLBACK] = 'https%3A%2F%2Fhellowmq.github.io'
      ..[OAUTH_TOKEN_SECRET] = '';
    return _instance;
  }

  static String _getSignature(
      {String httpVerb = HttpVerb.GET,
      String requestPath = FlickrConstant.FLICKR_OAUTH_REQUEST_TOKEN_PATH,
      SplayTreeMap<String, String> params,
      String tokenSecret}) {
    assert(httpVerb != null);
    assert(requestPath != null);
    assert(params != null);
    assert(tokenSecret != null);

    String _generateBaseString() {
      String requestUrlString =
          Uri.encodeComponent(FLICKR_HOST_URL + requestPath);
      String paramsString = Uri.encodeComponent(
          params.keys.map((key) => '$key=${params[key]}').toList().join('&'));
      return '$httpVerb&$requestUrlString&$paramsString';
    }

    String _generateKey() => '${app_key.secret}&$tokenSecret';
    return SignUtils.hmacSha1Sign(_generateKey(), _generateBaseString());
  }

  Future<String> requestToken() async {
    void _generateSignature() {
      SplayTreeMap<String, String> params = new SplayTreeMap()
        ..[OAUTH_NONCE] = authParamsMap[OAUTH_NONCE]
        ..[OAUTH_TIMESTAMP] = authParamsMap[OAUTH_TIMESTAMP]
        ..[OAUTH_CONSUMER_KEY] = authParamsMap[OAUTH_CONSUMER_KEY]
        ..[OAUTH_SIGNATURE_METHOD] = authParamsMap[OAUTH_SIGNATURE_METHOD]
        ..[OAUTH_VERSION] = authParamsMap[OAUTH_VERSION]
        ..[OAUTH_CALLBACK] = authParamsMap[OAUTH_CALLBACK];
      final string = OAUTH_TOKEN_SECRET;
      String tokenSecret = authParamsMap[string];

      authParamsMap[OAUTH_SIGNATURE] = FlickrOAuth._getSignature(
          httpVerb: HttpVerb.GET,
          requestPath: FlickrConstant.FLICKR_OAUTH_REQUEST_TOKEN_PATH,
          params: params,
          tokenSecret: tokenSecret);
    }

    String _generateRequestTokenUrl() {
      const List<String> paramsNames = [
        OAUTH_NONCE,
        OAUTH_TIMESTAMP,
        OAUTH_CONSUMER_KEY,
        OAUTH_SIGNATURE_METHOD,
        OAUTH_VERSION,
        OAUTH_SIGNATURE,
        OAUTH_CALLBACK
      ];

      String paramsString = authParamsMap.keys
          .where((key) => paramsNames.contains(key))
          .map((key) => '$key=${authParamsMap[key]}')
          .toList()
          .join('&');
      return '${FlickrConstant.FLICKR_HOST + FlickrConstant.FLICKR_OAUTH_REQUEST_TOKEN_PATH}?$paramsString';
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
      print("request token get data:\n${Uri.splitQueryString(response.body)}");
      print('before addAll: $authParamsMap');
      authParamsMap.addAll(Uri.splitQueryString(response.body));
      print('after addAll : $authParamsMap');
      if (authParamsMap[OAUTH_CALLBACK_CONFIRMED] != 'true') {
        throw Exception('oauth_callback_confirmed == false');
      }
    }

    _generateSignature();

    await MQHttpByUrl.getM(_generateRequestTokenUrl(), parseRequestToken);

    return authParamsMap[OAUTH_CALLBACK_CONFIRMED];
  }

//  取得使用者授權
  String generateAuthorizeUrl() {
    if (authParamsMap.containsKey(OAUTH_TOKEN) &&
        authParamsMap[OAUTH_TOKEN].isNotEmpty) {
      return authParamsMap[OAUTH_TOKEN];
    } else {
      throw Exception('authParamsMap["oauth_token"].isEmpty');
    }
  }

//  交換要求記錄，以取得存取記錄的權限
  Future<String> accessToken() async {
    void _generateSignature() {
      SplayTreeMap<String, String> params = new SplayTreeMap()
        ..[OAUTH_NONCE] = authParamsMap[OAUTH_NONCE]
        ..[OAUTH_TIMESTAMP] = authParamsMap[OAUTH_TIMESTAMP]
        ..[OAUTH_VERIFIER] = authParamsMap[OAUTH_VERIFIER]
        ..[OAUTH_CONSUMER_KEY] = authParamsMap[OAUTH_CONSUMER_KEY]
        ..[OAUTH_SIGNATURE_METHOD] = authParamsMap[OAUTH_SIGNATURE_METHOD]
        ..[OAUTH_VERSION] = authParamsMap[OAUTH_VERSION]
        ..[OAUTH_TOKEN] = authParamsMap[OAUTH_TOKEN];
      String tokenSecret = authParamsMap[OAUTH_TOKEN_SECRET];
      authParamsMap[OAUTH_SIGNATURE] = FlickrOAuth._getSignature(
          httpVerb: HttpVerb.GET,
          requestPath: FlickrConstant.FLICKR_OAUTH_ACCESS_TOKEN_PATH,
          params: params,
          tokenSecret: tokenSecret);
    }

    String _generateAccessTokenUrl() {
      const List<String> paramsNames = [
        OAUTH_NONCE,
        OAUTH_TIMESTAMP,
        OAUTH_VERIFIER,
        OAUTH_CONSUMER_KEY,
        OAUTH_SIGNATURE_METHOD,
        OAUTH_VERSION,
        OAUTH_TOKEN,
        OAUTH_SIGNATURE
      ];
      String paramsString = authParamsMap.keys
          .where((key) => paramsNames.contains(key))
          .map((key) => '$key=${authParamsMap[key]}')
          .toList()
          .join('&');
      return '${FlickrConstant.FLICKR_HOST + FlickrConstant.FLICKR_OAUTH_ACCESS_TOKEN_PATH}?$paramsString';
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
      if (authParamsMap.containsKey('oauth_problem')) {
        throw Exception(
            'FlickrOAuth.Authorize authParamsMap["oauth_problem"] == ${authParamsMap["oauth_problem"]}');
      }
    }

    _generateSignature();
    await MQHttpByUrl.getM(_generateAccessTokenUrl(), parseAccessToken);
    return authParamsMap[OAUTH_TOKEN_SECRET];
  }

//  透過 OAuth 呼叫 Flickr API
  Future<String> testLogin() async {
    void _generateSignature() {
      SplayTreeMap<String, String> params = new SplayTreeMap()
        ..[FORMAT] = JSON
        ..[METHOD] = FlickrConstant.FLICKR_TEST_LOGIN
        ..[NOJSONCALLBACK] = '1'
        ..[OAUTH_CONSUMER_KEY] = authParamsMap[OAUTH_CONSUMER_KEY]
        ..[OAUTH_NONCE] = authParamsMap[OAUTH_NONCE]
        ..[OAUTH_SIGNATURE_METHOD] = authParamsMap[OAUTH_SIGNATURE_METHOD]
        ..[OAUTH_TIMESTAMP] = authParamsMap[OAUTH_TIMESTAMP]
        ..[OAUTH_TOKEN] = authParamsMap[OAUTH_TOKEN]
        ..[OAUTH_VERIFIER] = authParamsMap[OAUTH_VERIFIER]
        ..[OAUTH_VERSION] = authParamsMap[OAUTH_VERSION];
      String tokenSecret = authParamsMap[OAUTH_TOKEN_SECRET];
      authParamsMap[OAUTH_SIGNATURE] = FlickrOAuth._getSignature(
          httpVerb: HttpVerb.GET,
          requestPath: FlickrConstant.FLICKR_REST_PATH,
          params: params,
          tokenSecret: tokenSecret);
    }

    String _generateTestLoginUrl() {
      String url =
          'https://www.flickr.com/services/rest?nojsoncallback=1&format=json&method=flickr.test.login&';
      const List<String> paramsNames = [
        OAUTH_NONCE,
        OAUTH_TIMESTAMP,
        OAUTH_VERIFIER,
        OAUTH_CONSUMER_KEY,
        OAUTH_SIGNATURE_METHOD,
        OAUTH_VERSION,
        OAUTH_SIGNATURE,
        OAUTH_TOKEN
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
