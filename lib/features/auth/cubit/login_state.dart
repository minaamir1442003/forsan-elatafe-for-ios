abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final String patientName;

  LoginSuccess({required this.token, required this.patientName});
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});  // 👈 خليها named parameter برضه
}