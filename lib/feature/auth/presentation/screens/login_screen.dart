import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final void Function()? onRegister;
  const LoginScreen({super.key, this.onRegister});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(hintText: 'Password', isPassword: true),
              ElevatedButton(
                onPressed: () {
                  // Handle registration logic here
                },
                child: const Text('Sign In'),
              ),
              TextButton(
                onPressed: onRegister,
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
