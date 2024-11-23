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
    print('Login Response: $responseBody'); // Debug log

    if (response.statusCode == 200) {
      // Now, we check if the response contains the 'token' field instead of 'data'
      if (responseBody.containsKey('token')) {
        String token = responseBody['token']; // Handle the token
        print('Token: $token'); // Debug log
        // You might want to store the token or use it for further requests
        // For now, let's assume the token is enough and return a dummy user
        return User(id: 1, name: 'Test User', email: email);
      } else {
        throw Exception('Token not found in response.');
      }
    } else {
      throw Exception(responseBody['message'] ?? 'Login failed.');
    }
  } catch (e) {
    print('Login Error: $e');
    rethrow; // Let the caller handle errors
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
    print('Register Response: $responseBody'); // Debug log

    if (response.statusCode == 200) {
      // Validate and process the backend response
      if (responseBody.containsKey('id')) {
        return User(
          id: responseBody['id'],
          name: name,
          email: email,
        );
      } else {
        throw Exception("Unexpected response structure: 'id' not found");
      }
    } else {
      // Handle server-side errors with a descriptive message
      throw Exception(responseBody['message'] ?? 'Registration failed.');
    }
  } catch (e) {
    print('Registration Error: $e');
    rethrow; // Propagate the error for further handling
  }
}

}
