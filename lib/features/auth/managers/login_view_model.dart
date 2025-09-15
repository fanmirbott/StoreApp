import 'package:flutter/foundation.dart';
import '../../../data/repositories/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _repository;

  LoginViewModel(this._repository);

  bool _isLoading = false;
  String? _token;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get errorMessage => _errorMessage;

  Future<void> login(String login, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _token = null;
    notifyListeners();

    final result = await _repository.login(login, password);

    result.fold(
          (error) {
        _errorMessage = error.toString();
        return null;
      },
          (data) {
        _token = data;
        return null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
