import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignUtils {
  static String hmacSha1Sign(String key, String baseString) {
    try {
      var hmacSha1 = new Hmac(sha1, utf8.encode(key));
      print(baseString);
      String signature = Uri.encodeComponent(
          base64.encode(hmacSha1.convert(utf8.encode(baseString)).bytes));
      return signature;
    } catch (e) {
      print(e);
      throw FormatException('Generate Signature Error');
    }
  }
}
