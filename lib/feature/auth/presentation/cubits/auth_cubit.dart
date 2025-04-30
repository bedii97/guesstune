import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesstune/feature/auth/domain/repos/auth_repo.dart';
import 'package:guesstune/feature/auth/presentation/cubits/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitialState());

  String _translateErrorMessage(supabase.AuthException e) {
    final code = e.code?.toLowerCase();
    if (code == null) {
      return 'Bilinmeyen bir hata oluştu.';
    }
    // Translate specific error codes to user-friendly messages
    if (code.contains('invalid_credentials')) {
      return 'Kullanıcı adı veya şifre yanlış.';
    }
    return 'Bir hata oluştu: ${e.message}';
  }

  Future<void> signin(String email, String password) async {
    try {
      final user = await authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthErrorState("Not authenticated"));
      }
    } on supabase.AuthException catch (e) {
      final errorMessage = _translateErrorMessage(e);
      emit(AuthErrorState(errorMessage));
    } catch (e) {
      emit(AuthErrorState("Bir hata oluştu: $e"));
    }
  }

  Future<void> signup(String email, String password, String name) async {
    try {
      final user = await authRepo.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      if (user != null) {
        emit(AuthRegisteredState("Kayıt başarılı!"));
      } else {
        emit(AuthErrorState("Not authenticated"));
      }
    } on supabase.AuthException catch (e) {
      final errorMessage = _translateErrorMessage(e);
      emit(AuthErrorState(errorMessage));
    } catch (e) {
      emit(AuthErrorState("Bir hata oluştu: $e"));
    }
  }
}
