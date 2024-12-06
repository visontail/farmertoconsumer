import 'dart:convert';

import 'package:farmertoconsumer/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';
import '../models/product.dart';
import '../storages/user_storage.dart';

class OrderService {
  static final OrderService _singleton = OrderService._internal();
  OrderService._internal();

  factory OrderService() {
    return _singleton;
  }

  final UserStorage _userStorage = UserStorage();

  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<Order?> postOrder(Product product, int quantity) async {
    final token = _userStorage.token.get() ?? "";
    final jsonBody = json.encode({
      'productId': product.id,
      'quantity': quantity,
    });

    try {
      final Map<String, String> headersWithAuth = {
        ...headers,
        'Authorization': 'Bearer $token'
      };

      final response = await http.post(
          Uri.parse(ordersEndPoint),
          headers: headersWithAuth,
          body: jsonBody,
      );

      final responseBody = json.decode(response.body);
      print('Response: $responseBody'); // debug log, remove in prod

      if (response.statusCode == 200) {
        Order order = Order.fromJson(responseBody);
        return order;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}