import 'dart:convert';
import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/services/common/get_all_return_value.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/api_endpoints.dart';

class ProductService extends ChangeNotifier {
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

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
}
