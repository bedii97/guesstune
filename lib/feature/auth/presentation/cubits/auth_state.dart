abstract class AuthState {}

//Initial state
class AuthInitialState extends AuthState {}

//Loading state
class AuthLoadingState extends AuthState {}

//Authenticated state
class AuthAuthenticatedState extends AuthState {}

//Error state
class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState(this.errorMessage);
}
