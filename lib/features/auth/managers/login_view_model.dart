import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    notifyListeners();

    final result = await _repository.login(login, password);

    result.fold(
          (error) {
        _errorMessage = error.toString();
      },
          (data) async {
        _token = data;
        // Tokenni SharedPreferences-ga saqlaymiz
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", _token!);
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
