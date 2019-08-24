import "dart:collection";
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as app_key;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class SigningRequestPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return SigningRequestPage();
  }

  @override
  _SigningRequestPageState createState() => _SigningRequestPageState();
}

class _SigningRequestPageState extends State<SigningRequestPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var requestToken = '';
  var signature = '';
  var tokenData = '';
  var callback = '';

  static const List<String> oauthKeys = [
    'oauth_callback_confirmed',
    'oauth_token',
    'oauth_token_secret'
  ];
  static const String URL =
      'https://www.flickr.com/services/oauth/request_token';
  Map<String, String> signingParamsMap = new SplayTreeMap()
    ..['oauth_nonce'] = '123123'
    ..['oauth_timestamp'] =
        ((new DateTime.now().millisecondsSinceEpoch / 1000).floor()).toString()
    ..['oauth_consumer_key'] = '82c6bf925a8bf9823d980b7a3785d4b3'
    ..['oauth_signature_method'] = 'HMAC-SHA1'
    ..['oauth_version'] = '1.0'
    ..['oauth_callback'] = 'http%3A%2F%2Fwww.example.com';

  String _generateBaseString() {
    Map<String, String> baseParamsMap = new SplayTreeMap()
      ..['oauth_nonce'] = '123123'
      ..['oauth_timestamp'] =
          ((new DateTime.now().millisecondsSinceEpoch / 1000).floor())
              .toString()
      ..['oauth_consumer_key'] = '82c6bf925a8bf9823d980b7a3785d4b3'
      ..['oauth_signature_method'] = 'HMAC-SHA1'
      ..['oauth_version'] = '1.0'
      ..['oauth_callback'] = 'http%3A%2F%2Fwww.example.com';
    String paramString = baseParamsMap.keys
        .map((name) => '$name=${baseParamsMap[name]}')
        .toList()
        .join('&');
    return 'GET&${Uri.encodeComponent(URL)}&${Uri.encodeComponent(paramString)}';
  }

  String _generateKey() {
    return '${app_key.secret}&$requestToken';
  }

  String _generateSignature() {
    try {
      var hmacSha1 = new Hmac(sha1, utf8.encode(_generateKey()));
      print(_generateBaseString());
      var result = hmacSha1.convert(utf8.encode(_generateBaseString())).bytes;
      return Uri.encodeComponent(base64.encode(result));
    } catch (e) {
      print(e);
      return '_generateSignature Error';
    }
  }

// Getting a Request Token
  _getRequestToken() async {
    String _getRequestTokenUrl() {
      Map<String, String> signingParamsMap = new SplayTreeMap()
        ..['oauth_nonce'] = '123123'
        ..['oauth_timestamp'] =
            ((new DateTime.now().millisecondsSinceEpoch / 1000).floor())
                .toString()
        ..['oauth_consumer_key'] = '82c6bf925a8bf9823d980b7a3785d4b3'
        ..['oauth_signature_method'] = 'HMAC-SHA1'
        ..['oauth_version'] = '1.0'
        ..['oauth_callback'] = 'http%3A%2F%2Fwww.example.com'
        ..['oauth_signature'] = signature;
      String paramString = signingParamsMap.keys
          .map((name) => '$name=${signingParamsMap[name]}')
          .toList()
          .join('&');
      return 'https://www.flickr.com/services/oauth/request_token' +
          '?' +
          paramString;
    }

    Function parseToken = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      tokenData = response.body;
    };
    await MQHttpByUrl.getM(_getRequestTokenUrl(), parseToken);
    setState(() {
      print(tokenData);
    });
  }

//  Getting the User Authorization
  _getUserAuthorization() async {
    String _getUserAuthorization() =>
        'https://www.flickr.com/services/oauth/authorize?oauth_token=${Uri.splitQueryString(tokenData)['oauth_token']}';

    Function parseUserAuthorization = (value) {
      final response = value as http.Response;
      try {
        if (response == null) {
          throw 'value == null';
        }
      } catch (e) {
        print(e.toString());
      }
      callback = response.body;
    };

    await MQHttpByUrl.getM(_getUserAuthorization(), parseUserAuthorization);
    setState(() {
      print(callback);
    });
  }

  _getAccessToken() async {
    String _getAccessTokenUrl() {
      Map<String, String> getAccessTokenParamsMap = new SplayTreeMap()
        ..addAll(signingParamsMap);

      return 'https://www.flickr.com/services/oauth/access_token?' +
          getAccessTokenParamsMap.keys
              .map((name) => '$name=${getAccessTokenParamsMap[name]}')
              .toList()
              .join('&');
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
      callback = response.body;
    };
    await MQHttpByUrl.getM(_getAccessTokenUrl(), parseAccessToken);
    setState(() {
      print('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: Text('Signing Request'),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              child: new Column(
                children: [
                  ListTile(
                    title: Text(_generateBaseString()),
                  ),
                  ListTile(
                    title: Text(_generateKey()),
                  ),
                  signature.isNotEmpty
                      ? ListTile(
                          title: Text(signature),
                        )
                      : Container(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('Generate Signature'),
                          onPressed: () {
                            setState(() {
                              signature = _generateSignature();
                            });
                          },
                        ),
                        FlatButton(
                          child: Text('Get Token'),
                          onPressed: _getRequestToken,
                        ),
                        FlatButton(
                          child: Text('Get Callback'),
                          onPressed: _getUserAuthorization,
                        ),
                        FlatButton(
                          child: Text('Get Callback'),
                          onPressed: _getAccessToken,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              child: new Column(
                children: Uri.splitQueryString(tokenData)
                    .keys
                    .map(
                      (String name) => ListTile(
                        title: Text(
                            '$name: ${Uri.splitQueryString(tokenData)[name]}'),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Card(
                child: Text(callback),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
