import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Material App Bar')),
        body: const Center(child: Text('Hello World')),
      ),
    );
  }
}
