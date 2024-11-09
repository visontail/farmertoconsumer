import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api_endpoints.dart';

class AuthService extends ChangeNotifier {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final jsonBody = json.encode({
      'email': email,
      'password': password,
    });

    final response = await http.post(
      Uri.parse(loginEndpoint),
      body: jsonBody,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    final responseBody = json.decode(response.body);

    print('Response: $responseBody');
    
    if (response.statusCode == 200) {
      return {
        'status': 'success',
        'data': responseBody,
      };
    
    } else {
      return {
        'status': 'error',
        'message': responseBody,
      };
    }
  }
}