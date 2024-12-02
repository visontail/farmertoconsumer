import 'dart:convert';
import 'package:farmertoconsumer/models/productCategory.dart';
import 'package:farmertoconsumer/services/common/get_all_return_value.dart';
import 'package:http/http.dart' as http;

import '../utils/api_endpoints.dart';

class CategoryService {
  static final CategoryService _singleton = CategoryService._internal();
  CategoryService._internal();

  factory CategoryService() {
    return _singleton;
  }

  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<GetAllReturnValue<ProductCategory>> getAll() async {
    final response = await http.get(
      Uri.parse(getAllCategoryEndpoint),
      headers: headers,
    );

    final responseBody = json.decode(response.body);

    return GetAllReturnValue(
        total: responseBody["total"],
        current: responseBody["current"],
        data: (responseBody["categories"] as List<dynamic>)
        .map((e) => ProductCategory.fromJson(e))
        .toList());
  }
}
