import 'dart:async';
import 'dart:convert';
import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:farmertoconsumer/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/services/common/get_all_return_value.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api_endpoints.dart';

class ProductService extends ChangeNotifier {
  AuthProvider authProvider = AuthProvider();
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<Product?> getProduct(String id) async {
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
        Product product = Product.fromJson(responseBody);
        return product;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<GetAllReturnValue<Product>> getAll(
      String? search, int? categoryId, int? skip, int? take) async {
    final response = await http.get(
      Uri.parse(getAllProductEndpoint(search, categoryId, skip, take)),
      headers: headers,
    );
    final responseBody = json.decode(response.body);

    return GetAllReturnValue(
        total: responseBody["total"],
        current: responseBody["current"],
        data: (responseBody["products"] as List<dynamic>)
            .map((e) => Product.fromJson(e))
            .toList());
  }

  // Create Product
  Future<bool> createProduct(Map<String, dynamic> productData) async {
    const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyNzkwMjI2fQ.nK9euTGcEf5LW7fkRBhLqliVbNBlsZgYF6bNwhbfoCs";
    // TODO: final token = await authProvider.getToken();

    final Map<String, String> headersWithAuth = {
      ...headers,
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        Uri.parse(productEndPoint),
        headers: headersWithAuth,
        body: json.encode(productData),
      );

      return response.statusCode == 201;
    } catch (e) {
      print("Error creating product: $e");
      return false;
    }
  }

  /// Update Product
  Future<bool> updateProduct(String id, Map<String, dynamic> productData) async {
    const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyNzkwMjI2fQ.nK9euTGcEf5LW7fkRBhLqliVbNBlsZgYF6bNwhbfoCs";
    //TODO: final token = await authProvider.getToken();
    final Map<String, String> headersWithAuth = {
      ...headers,
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.patch(
        Uri.parse(productEndPoint + id),
        headers: headersWithAuth,
        body: json.encode(productData),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating product: $e");
      return false;
    }
  }

  // Delete Product
  Future<bool> deleteProduct(String id) async {
    const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyNzkwMjI2fQ.nK9euTGcEf5LW7fkRBhLqliVbNBlsZgYF6bNwhbfoCs";
    //final token = await authProvider.getToken();
    final Map<String, String> headersWithAuth = {
      ...headers,
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.delete(
        Uri.parse(productEndPoint + id),
        headers: headersWithAuth,
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting product: $e");
      return false;
    }
  }
}

