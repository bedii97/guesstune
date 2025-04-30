import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:guesstune/feature/auth/presentation/screens/auth_screen.dart';
import 'package:guesstune/feature/auth/presentation/screens/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  await Supabase.initialize(url: env['URL'] ?? '', anonKey: env['ANON'] ?? '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: AuthScreen());
  }
}
