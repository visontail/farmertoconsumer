import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:farmertoconsumer/storages/user_storage.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final UserStorage _userStorage = UserStorage();
  final WriteableUserStorage _writeableUserStorage = WriteableUserStorage();
  final AuthService _authService = AuthService();

  AuthenticatedUser? get user => _userStorage.user.get();
  bool get isAuthenticated => user != null;

  Future<AuthenticatedUser> login(String email, String password) async {
    try {
      final token = await _authService.login(email, password);
      _writeableUserStorage.token.set(token);

      final user = await _authService.profile();
      _writeableUserStorage.user.set(user);

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
      _writeableUserStorage.token.set(rec.$2);

      final user = await _authService.profile();
      _writeableUserStorage.user.set(user);

      notifyListeners();

      return user;
    } catch (e) {
      logout();
      rethrow;
    }
  }

  void logout() {
    _writeableUserStorage.token.set(null);
    _writeableUserStorage.user.set(null);
    notifyListeners();
  }
}
