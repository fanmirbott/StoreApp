part of 'auth_bloc.dart';

class AuthState {
  final Status status;
  final String? token;
  final String? errorMessage;
  final bool isSuccess;

  AuthState({
    required this.status,
    this.token,
    this.errorMessage,
    this.isSuccess = false,
  });

  factory AuthState.initial() => AuthState(status: Status.initial);

  AuthState copyWith({
    Status? status,
    String? token,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
