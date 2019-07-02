import "dart:collection";
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/key.dart' as app_key;

class SigningRequestPage extends StatefulWidget {
  @override
  _SigningRequestPageState createState() => _SigningRequestPageState();
}

class _SigningRequestPageState extends State<SigningRequestPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var requestToken = '';
  var signature = '';
  static const String URL =
      'http://www.flickr.com/services/oauth/request_token?';
  Map<String, String> params = new SplayTreeMap()
    ..['oauth_nonce'] = '123123'
    ..['oauth_timestamp'] =
        ((new DateTime.now().millisecondsSinceEpoch / 1000).floor()).toString()
    ..['oauth_consumer_key'] = '82c6bf925a8bf9823d980b7a3785d4b3'
    ..['oauth_signature_method'] = 'HMAC-SHA1'
    ..['oauth_version'] = '1.0'
    ..['oauth_callback'] = 'http%3A%2F%2Fwww.example.com';

//  oauth_nonce=89601180
//  &oauth_timestamp=1305583298
//  &oauth_consumer_key=653e7a6ecc1d528c516cc8f92cf98611
//  &oauth_signature_method=HMAC-SHA1
//  &oauth_version=1.0
//  &oauth_callback=http%3A%2F%2Fwww.example.com

  String _generateBaseString() {
    String paramString = '';
    for (String name in params.keys) {
      paramString += '&$name=${params[name]}';
    }
    return 'GET&' + Uri.encodeComponent('$URL$paramString');
  }

  String _generateKey() {
    return '${app_key.secret}&$requestToken';
  }

  String _generateSignature() {
    try {
      var hmacSha1 = new Hmac(sha1, utf8.encode(_generateKey()));
      var result = hmacSha1.convert(utf8.encode(_generateBaseString())).bytes;
      return Uri.encodeComponent(base64.encode(result));
//      return utf8.decode(result);
    } catch (e) {
      print(e);
      return '123';
    }
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
        ],
      ),
    );
  }
}
