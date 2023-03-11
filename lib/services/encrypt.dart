import 'dart:convert';
import 'package:crypto/crypto.dart';

class ServiceCrypto {
  ServiceCrypto();

  final String _key = "jxudx-nP8Gk-PWAjc";

  String encrypt(String text) {
    var bytes = utf8.encode(text);
    var hmacSha512 = Hmac(sha512, utf8.encode(_key));
    var digest = hmacSha512.convert(bytes);
    return digest.toString();
  }
}
