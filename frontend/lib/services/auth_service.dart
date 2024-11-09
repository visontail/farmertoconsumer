import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/api_endpoints.dart';

class AuthService extends ChangeNotifier {
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<Map<String, dynamic>> login(String email, String password) async {
    final jsonBody = json.encode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse(loginEndpoint),
        body: jsonBody,
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      print('Response: $responseBody'); // debug log, remove in prod

      return {
        'status': 'success',
        'data': responseBody,
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> register(String email, String name, String password, String confirmPassword) async {
    final jsonBody = json.encode({
      'email': email,
      'name': name,
      'password': password,
      'confirmPassword': confirmPassword,
    });

    try {
      final response = await http.post(
        Uri.parse(registerEndpoint),
        body: jsonBody,
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      print('Response: $responseBody'); // debug log, remove in prod
      
      return {
        'status': 'success',
        'data': responseBody,
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }
}
