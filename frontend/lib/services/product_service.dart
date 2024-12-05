import 'dart:async';
import 'dart:convert';
import 'package:farmertoconsumer/storages/user_storage.dart';
import 'package:farmertoconsumer/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/services/common/get_all_return_value.dart';

class ProductService {
  static final ProductService _singleton = ProductService._internal();
  ProductService._internal();

  factory ProductService() {
    return _singleton;
  }

  final UserStorage _userStorage = UserStorage();

  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<Product?> getProduct(String id) async {
    final token = _userStorage.token.get() ?? "";

    try {
      final Map<String, String> headersWithAuth = {
        ...headers,
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(Uri.parse(productEndPoint + id),
          headers: headersWithAuth);

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

    final token = _userStorage.token.get() ?? "";
    print(token);

    return GetAllReturnValue(
        total: responseBody["total"],
        current: responseBody["current"],
        data: (responseBody["products"] as List<dynamic>)
            .map((e) => Product.fromJson(e))
            .toList());
  }

  // Create Product
  Future<void> createProduct(Map<String, dynamic> productData) async {
    final token = _userStorage.token.get() ?? "";

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

      if (response.statusCode != 200) {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      print("Error creating product: $e");
      throw Exception('Error creating product: $e');
    }
  }

  /// Update Product
  Future<void> updateProduct(String id, Map<String, dynamic> productData) async {
    final token = _userStorage.token.get() ?? "";

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

      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      print("Error updating product: $e");
      throw Exception('Error updating product: $e');
    }
  }

  // Delete Product
  Future<void> deleteProduct(String id) async {
    //const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMyNzkwMjI2fQ.nK9euTGcEf5LW7fkRBhLqliVbNBlsZgYF6bNwhbfoCs";
    //const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsImlhdCI6MTczMjg3NTc3N30.xSJTfHrZhyutX7-8Ai7q1AxXS282_eXzVi7C-U_HOQ4";
    //const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzMzMDU1MDE2fQ.wRp-7H9wRl8pJSBkp6nKjTPJwfqygRhhaHrdVkwrs78";
    //TODO: final token = await authProvider.getToken();

    final token = _userStorage.token.get() ?? "";

    final Map<String, String> headersWithAuth = {
      ...headers,
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.delete(
        Uri.parse(productEndPoint + id),
        headers: headersWithAuth,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      print("Error deleting product: $e");
      throw Exception('Error deleting product: $e');
    }
  }
}
