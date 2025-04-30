import 'package:flutter/material.dart';
import 'package:guesstune/feature/auth/presentation/screens/login_screen.dart';
import 'package:guesstune/feature/auth/presentation/screens/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginScreen(onRegister: toggleAuthMode)
        : RegisterScreen(onLogin: toggleAuthMode);
  }
}
