import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_tutorial/core/api_url.dart';
import 'package:riverpod_tutorial/model/login_model.dart';

// Riverpod provider for auth state
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  Future<LoginModel> loginUser(String username, String password) async {
    try {
      // final bodyData = {
      //   "username": username.toString().trim(),
      //   "password": password.toString().trim(),
      //   "expiresInMins": 30
      // };
      final bodyData = {
        "username": "sophiab",
        "password": "sophiabpass",
        "expiresInMins": 30
      };
      debugPrint("bodyData:$bodyData");
      final response = await http.post(
        Uri.parse(ApiUrl.loginApi),
        body: jsonEncode(bodyData),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint("response code==>${response.statusCode}");
      debugPrint("response body==>${response.body}");
      if (response.statusCode == 200) {
        final loginModel = loginModelFromJson(response.body);
        return loginModel;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e, stack) {
      debugPrint("Exception: $e, Stacktrace: $stack");
      throw Exception("Failed to login");
    }
  }
}
