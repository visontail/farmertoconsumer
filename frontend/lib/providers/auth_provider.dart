import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:farmertoconsumer/storages/user_storage.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final UserStorage _userStorage = UserStorage();
  final AuthService _authService = AuthService();

  AuthenticatedUser? get user => _userStorage.user.get();
  bool get isAuthenticated => user != null;

  Future<AuthenticatedUser> login(String email, String password) async {
    try {
      final token = await _authService.login(email, password);
      _userStorage.token.set(token);

      final user = await _authService.profile();
      _userStorage.user.set(user);

      notifyListeners();

      return user;
    } catch (e) {
      logout();
      rethrow;
    }
  }

  Future<AuthenticatedUser> register(String email, String name, String password,
      String confirmPassword) async {
    try {
      final rec =
          await _authService.register(email, name, password, confirmPassword);
      _userStorage.token.set(rec.$2);

      final user = await _authService.profile();
      _userStorage.user.set(user);

      notifyListeners();

      return user;
    } catch (e) {
      logout();
      rethrow;
    }
  }

  void logout() {
    _userStorage.token.set(null);
    _userStorage.user.set(null);
    notifyListeners();
  }
}
