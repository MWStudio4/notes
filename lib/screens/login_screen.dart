import 'package:flutter/material.dart';
import 'package:notes_example/models/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final bool isLoginScreen;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key key, this.isLoginScreen = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoginScreen ? 'Вход' : 'Регистрация',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  TextFormField(
                    controller: _loginController,
                    decoration: InputDecoration(
                      hintText: 'Login',
                    ),
                    validator: (value) {
                      return value.length < 2 ? 'Логин должен содержать минимум 2 символа' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      return value.length < 2 ? 'Пароль должен содержать минимум 2 символа' : null;
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 64)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),
                      child: Text(isLoginScreen ? 'Войти' : 'Регистрация'),
                      onPressed: () {
                        final _auth = Provider.of<AuthState>(context, listen: false);
                        final _isValid = _formKey.currentState.validate();
                        if (isLoginScreen && _isValid) {
                          _auth.signin(login: _loginController.text, password: _passwordController.text);
                        }
                        if (!isLoginScreen && _isValid) {
                          _auth.signin(login: _loginController.text, password: _passwordController.text);
                        }
                      }
                      // Navigator.pushReplacementNamed(context, '/catalog');

                      ),
                  FlatButton(
                    child: Text(isLoginScreen ? 'Регистрация' : 'Отмена'),
                    onPressed: () {
                      if (isLoginScreen) {
                        Navigator.of(context).pushNamed('/register');
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
