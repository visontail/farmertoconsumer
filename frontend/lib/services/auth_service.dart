import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../utils/api_endpoints.dart';

class AuthService extends ChangeNotifier {
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<User?> login(String email, String password) async {
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
    print('Login Response: $responseBody');

    if (response.statusCode == 200) {
      if (responseBody.containsKey('token')) {
        String token = responseBody['token'];
        print('Token: $token');
        // TODO: Store the token securely
        return User(id: 1, name: 'Test User');
      } else {
        throw Exception('Token not found in response.');
      }
    } else {
      throw Exception(responseBody['message'] ?? 'Login failed.');
    }
  } catch (e) {
    print('Login Error: $e');
    rethrow;
  }
}



  Future<User?> register(String email, String name, String password, String confirmPassword) async {
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
    print('Register Response: $responseBody');

    if (response.statusCode == 200) {
      if (responseBody.containsKey('id')) {
        return User(
          id: responseBody['id'],
          name: name,
        );
      } else {
        throw Exception("Unexpected response structure: 'id' not found");
      }
    } else {
      throw Exception(responseBody['message'] ?? 'Registration failed.');
    }
  } catch (e) {
    print('Registration Error: $e');
    rethrow;
  }
}

}
