import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/sign_up_repositories.dart';

class SignUpViewModel extends ChangeNotifier {
  final SignUpRepositories _repository;

  SignUpViewModel(this._repository);

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  bool isSuccess = false;

  Future<bool> signUp(String fullName, String email, String password) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    isSuccess = false;
    notifyListeners();

    final result = await _repository.signUp(fullName, email, password);

    await result.fold(
          (error) {
        errorMessage = error.toString();
        isSuccess = false;
      },
          (token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);

        successMessage = "Ro'yxatdan o'tish muvaffaqiyatli!";
        isSuccess = true;
      },
    );

    isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
