import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesstune/feature/auth/presentation/cubits/auth_cubit.dart';
import 'package:guesstune/feature/auth/presentation/cubits/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onLogin;
  const RegisterScreen({super.key, this.onLogin});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        } else if (state is AuthRegisteredState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
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
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(hintText: 'Name'),
                CustomTextField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(hintText: 'Password', isPassword: true),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().signup(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: widget.onLogin,
                  child: const Text('Already have an account? Login'),
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
