
import 'package:farmertoconsumer/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    try {
      await _authService.login(email, password);
      _isAuthenticated = true;
      print('Logged in');
      notifyListeners();
    } catch (e) {
      _isAuthenticated = false;
      print("Error logging in: $e");
      rethrow;
    }
  }

}