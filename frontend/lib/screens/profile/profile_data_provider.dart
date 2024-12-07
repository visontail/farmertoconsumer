//import 'package:farmertoconsumer/models/product.dart';
//import 'package:farmertoconsumer/models/productCategory.dart';
//import 'package:farmertoconsumer/services/category_service.dart';
//import 'package:farmertoconsumer/services/product_service.dart';
import 'package:farmertoconsumer/storages/user_storage.dart';
import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileDataProvider extends ChangeNotifier {
  final UserStorage _userStorage = UserStorage();

  AuthenticatedUser? user;
  int? userId;
  String token = '';
  bool isProducer = false;

  ProfileDataProvider() {
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

  AuthenticatedUser? getUser() {
    return user;
  }

}
