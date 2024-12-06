import 'package:farmertoconsumer/storages/user_storage.dart';
import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:farmertoconsumer/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderDataProvider extends ChangeNotifier {
  final UserStorage _userStorage = UserStorage();

  Order? order;
  AuthenticatedUser? user;
  int? userId;
  String token = '';
  bool isProducer = false;

  OrderDataProvider() {
    this.user = _userStorage.user.get();
    this.userId = this.user?.id;
    this.token = _userStorage.token.get() ?? "";
  }


  int? getUserId() {
    return userId;
  }

  String getToken() {
    return token;
  }

  Order? getOrder() {
    return order;
  }

  // Fetch order details from the backend
  Future<Order?> fetchOrderDetails(orderId) async {
    final String token = this.getToken();

    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/orders/$orderId'), // Update URL with actual endpoint
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      this.order = Order.fromJson(data);
      return this.order;
    } else {
      throw Exception('Failed to load order');
    }
  }

  bool isRelevantProducer(Order? order) {
    if(order == null) {
      return false;
    }

    final int? userId = this.getUserId();
    if(order?.product?.user?.id == userId) {
      return true;
    }
    
    return false;
  }
}
