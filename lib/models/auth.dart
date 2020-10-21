import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuthState with ChangeNotifier {
  final Box _authBox = Hive.box('authBox');

  bool _isAuthenticated = false;


  Future<void> signup({@required String login, @required String password}) async {
    await _authBox.put('login', login);
    await _authBox.put('password', password);
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<bool> signin({@required String login, @required String password}) async {
    final _l = _authBox.get('login') as String;
    final _p = _authBox.get('password') as String;
    if (_l == login && _p == password) {
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _authBox.delete('login');
    _authBox.delete('password');
    _authBox.put('authenticated', false);
    _isAuthenticated = false;
    notifyListeners();
  }

  bool get authenticated => _isAuthenticated;
}
