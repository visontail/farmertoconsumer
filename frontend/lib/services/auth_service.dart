import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api_endpoints.dart';

class AuthService extends ChangeNotifier {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginEndpoint),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return {
        'status': 'success',
        'data': response.body,
      };
    } else {
      return {
        'status': 'error',
        'message': response.body,
      };
    }
  }



}