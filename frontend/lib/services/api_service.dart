import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = '';

  Future<http.Response> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    return response;
  }

  Future<http.Response> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    return response;
  }

  Future<http.Response> fetchFeed() async {
    final response = await http.get(
      Uri.parse('$baseUrl/feed'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<http.Response> fetchProductDetails(int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$productId'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<http.Response> fetchUserProfile(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
