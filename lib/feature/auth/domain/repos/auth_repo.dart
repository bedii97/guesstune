import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User?> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut();
}
