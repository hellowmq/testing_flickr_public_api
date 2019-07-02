import "dart:collection";
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as app_key;
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class SigningRequestPage extends StatefulWidget {
  @override
  _SigningRequestPageState createState() => _SigningRequestPageState();
}

class _SigningRequestPageState extends State<SigningRequestPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var requestToken = '';
  var signature = '';
  var tokenData = '';
  static const String URL =
      'https://www.flickr.com/services/oauth/request_token';
  Map<String, String> params = new SplayTreeMap()
    ..['oauth_nonce'] = '123123'
    ..['oauth_timestamp'] =
        ((new DateTime.now().millisecondsSinceEpoch / 1000).floor()).toString()
    ..['oauth_consumer_key'] = '82c6bf925a8bf9823d980b7a3785d4b3'
    ..['oauth_signature_method'] = 'HMAC-SHA1'
    ..['oauth_version'] = '1.0'
    ..['oauth_callback'] = 'http%3A%2F%2Fwww.example.com';

  String _generateBaseString() {
    String paramString = '';
    paramString =
        params.keys.map((name) => '$name=${params[name]}').toList().join('&');
//    for (String name in params.keys) {
//      paramString += '%3D$name%26${params[name]}';
//    }
    return 'GET&' +
        Uri.encodeComponent(URL) +
        '&' +
        Uri.encodeComponent(paramString);
//        paramString;
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
//      return utf8.decode(result);
    } catch (e) {
      print(e);
      return '123';
    }
  }

  String _generateFullUrl() {
    String paramString;
    paramString =
        params.keys.map((name) => '$name=${params[name]}').toList().join('&');
    return URL + '?' + paramString + '&oauth_signature=$signature';
  }

  _getToken() async {
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
    await MQHttpOAuthGet.getM(_generateFullUrl(), parseToken);
    setState(() {
      print(tokenData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      floatingActionButton: new FloatingActionButton(onPressed: () {
        setState(() {
          signature = _generateSignature();
        });
      }),
      appBar: new AppBar(
        title: Text('Signing Request'),
        actions: <Widget>[
          FlatButton(
            child: Text('Get Token'),
            onPressed: _getToken,
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          ListTile(
            title: Text(_generateBaseString()),
          ),
          ListTile(
            title: Text(_generateKey()),
          ),
          ListTile(
            title: Text(signature),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              child: new Column(
                children: Uri.splitQueryString(tokenData)
                    .keys
                    .map((String name) =>
                        Text('$name: ${Uri.splitQueryString(tokenData)[name]}'))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
