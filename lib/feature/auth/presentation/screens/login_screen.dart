import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesstune/feature/auth/presentation/cubits/auth_cubit.dart';
import 'package:guesstune/feature/auth/presentation/cubits/auth_state.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onRegister;
  const LoginScreen({super.key, this.onRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login Oldun"),
              duration: const Duration(seconds: 10),
            ),
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 10),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
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
                  controller: emailController,
                ),
                CustomTextField(
                  hintText: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().signin(
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  child: const Text('Sign In'),
                ),
                TextButton(
                  onPressed: widget.onRegister,
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
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
  final TextEditingController? controller;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
