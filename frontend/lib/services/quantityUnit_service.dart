import 'dart:convert';
import 'package:farmertoconsumer/models/quantityUnit.dart';
import 'package:farmertoconsumer/services/common/get_all_return_value.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/api_endpoints.dart';

class QuantityUnitService extends ChangeNotifier {
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<GetAllReturnValue<QuantityUnit>> getAll() async {
    final response = await http.get(
      Uri.parse(getAllQuantityUnitEndpoint),
      headers: headers,
    );

    final responseBody = json.decode(response.body);

    return GetAllReturnValue(
        total: responseBody["total"],
        current: responseBody["current"],
        data: (responseBody["quantityUnits"] as List<dynamic>)
        .map((e) => QuantityUnit.fromJson(e))
        .toList());
  }
}
