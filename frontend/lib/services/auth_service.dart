import 'dart:convert';
import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:farmertoconsumer/storages/user_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/api_endpoints.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  AuthService._internal();

  factory AuthService() {
    return _singleton;
  }

  final UserStorage _userStorage = UserStorage();

  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  /// Returns token
  Future<String> login(String email, String password) async {
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
          return token;
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

  /// Returns (id, token)
  Future<(String, String)> register(String email, String name, String password,
      String confirmPassword) async {
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
        final String id = responseBody['id'];
        final String token = responseBody['token'];
        return (id, token);
      } else {
        throw Exception(responseBody['message'] ?? 'Registration failed.');
      }
    } catch (e) {
      print('Registration Error: $e');
      rethrow;
    }
  }

  /// Returns token
  Future<AuthenticatedUser> profile() async {
    final token = _userStorage.token.get() ?? "";
    try {
      final response = await http.get(
        Uri.parse(authProfileEndpoint),
        headers: {...headers, 'Authorization': 'Bearer $token'},
      );

      final responseBody = json.decode(response.body);
      print('Profile Response: $responseBody');

      if (response.statusCode == 200) {
        return AuthenticatedUser.fromJson(responseBody);
      } else {
        throw Exception(responseBody['message'] ?? 'Request Error');
      }
    } catch (e) {
      print('Request Error: $e');
      rethrow;
    }
  }
}
