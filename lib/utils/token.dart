import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shopconnect/constants.dart';

class Token {
  static void set(String token) async {
    final storage = FlutterSecureStorage();
    storage.write(key: 'token', value: token);
  }

  static Future<void> delete() async {
    final storage = FlutterSecureStorage();
    storage.delete(key: 'token');
  }

  static Future<String> get() async {
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      var tokenMap = tryParse(token);
      if (((tokenMap['exp'] * 1000) - 86400000) < DateTime.now().millisecondsSinceEpoch) {
        final Map<String, String> header = {"Authorization": "Bearer $token", "Content-type": "application/json"};

        http.Response response = await http.post(
          AppConstants.apiURL + "/auth/refresh",
          headers: header);

        int statusCode = response.statusCode;

        if (statusCode == 200) {
          var tokenResponse = jsonDecode(response.body);
          set(tokenResponse['token']);
          return tokenResponse['token'];
        } else {
          return null;
        } 
      } else {
        final Map<String, String> header = {"Authorization": "Bearer $token", "Content-type": "application/json"};

        http.Response response = await http.get(
          AppConstants.apiURL + "/auth/validate",
          headers: header);

        int statusCode = response.statusCode;
        if (statusCode == 200) {
          return token;
        } else {
          return null;
        } 
      }
    } else {
      return null;
    }
  }

  static Map<String, dynamic> tryParse(String token) {
    if (token == null) return null;

    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload = parts[1];
    var normalized = base64Url.normalize(payload);

    var resp = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) return null;

    return payloadMap;
  }
}