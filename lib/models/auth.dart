import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuthState with ChangeNotifier {
  final Box _authBox = Hive.box('authBox');

  bool _isAuthenticated;
  String _login;
  String _password;

  AuthState() {
    _isAuthenticated = _authBox.get('authenticated', defaultValue: false) as bool;
  }

  Future<void> signup({@required String login, @required String password}) async {
    _login = login;
    _password = password;
    await _authBox.put('login', login);
    await _authBox.put('password', password);
    await _authBox.put('authenticated', true);
    _isAuthenticated = true;
    notifyListeners();
  }

  void signin({@required String login, @required String password}) {
    _login = login;
    _password = password;
    _authBox.put('login', login);
    _authBox.put('password', password);
    _authBox.put('authenticated', true);
    _isAuthenticated = true;
    notifyListeners();
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
