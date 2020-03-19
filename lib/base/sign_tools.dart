import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignUtils {
  static String hmacShaSign(Hash hash, String key, String baseString) {
    try {
      var hmacHash = new Hmac(hash, utf8.encode(key));
      print(baseString);
      String signature = Uri.encodeComponent(
          base64.encode(hmacHash
              .convert(utf8.encode(baseString))
              .bytes));
      return signature;
    } catch (e) {
      print(e);
      throw FormatException('Generate Signature Error');
    }
  }

  /// Sha1 is probably unsafe. You should use Sha256 unless the protocol assign
  /// Sha1 as the only sign method.
  static String hmacSha1Sign(String key, String baseString) =>
      hmacShaSign(sha1, key, baseString);

  String hmacSha256Sign(String key, String baseString) =>
      hmacShaSign(sha256, key, baseString);
}
