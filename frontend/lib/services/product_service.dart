import 'dart:convert';

import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:farmertoconsumer/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  AuthProvider authProvider = AuthProvider();
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<Map<String, dynamic>> getProducts() async {
    try {
      const token = "?????";
      //TODO: final token = await authProvider.getToken();
      final Map<String, String> headersWithAuth = {
        ...headers,
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        Uri.parse(productsEndPoint),
        headers: headersWithAuth,
      );

      final responseBody = json.decode(response.body);
      print('Response: $responseBody'); // debug log, remove in prod

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'data': responseBody,
        };
      } else {
        return {
          'status': 'error',
          'message': responseBody['message'] ??
              'An error occurred (HTTP ${response.statusCode})',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getProduct(String id) async {
    const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImlhdCI6MTczMTc2NTcxMn0.RQERtf98QOLVfjYORRBOVGgCGMmlqXeTR_q7r5duZBA";
    //TODO: final token = await authProvider.getToken();
    try {
      final Map<String, String> headersWithAuth = {
        ...headers,
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        Uri.parse(productEndPoint + id),
        headers: headersWithAuth
      );

      final responseBody = json.decode(response.body);
      print('Response: $responseBody'); // debug log, remove in prod

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'data': responseBody,
        };
      } else {
        return {
          'status': 'error',
          'message': responseBody['message'] ??
              'An error occurred (HTTP ${response.statusCode})',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }
}