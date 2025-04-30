import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesstune/feature/auth/data/supabase_auth_repo.dart';
import 'package:guesstune/feature/auth/presentation/cubits/auth_cubit.dart';
import 'package:guesstune/feature/auth/presentation/screens/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['URL'] ?? "",
    anonKey: dotenv.env['ANON'] ?? "",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final supabaseAuthRepo = SupabaseAuthRepo();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(supabaseAuthRepo),
      child: MaterialApp(title: 'Material App', home: AuthScreen()),
    );
  }
}
