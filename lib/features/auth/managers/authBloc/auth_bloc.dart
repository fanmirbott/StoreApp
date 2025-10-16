import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(AuthState.initial()) {
    on<LoginRequested>(_onLogin);
    on<SignUpRequested>(_onSignUp);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));
    final result = await _repository.login(event.email, event.password);

    await result.fold(
          (error) async {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      },
          (token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        emit(state.copyWith(status: Status.success, token: token));
      },
    );
  }

  Future<void> _onSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));
    final result = await _repository.signUp(
      event.fullName,
      event.email,
      event.password,
    );

    await result.fold(
          (error) async {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      },
          (token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        emit(state.copyWith(
          status: Status.success,
          token: token,
          isSuccess: true,
        ));
      },
    );
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await _repository.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    emit(AuthState.initial());
  }
}
