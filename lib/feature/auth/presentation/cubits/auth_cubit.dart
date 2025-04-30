import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesstune/feature/auth/domain/repos/auth_repo.dart';
import 'package:guesstune/feature/auth/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitialState());
  final String email = "";

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
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
