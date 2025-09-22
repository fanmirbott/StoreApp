import 'package:flutter/foundation.dart';
import '../../../data/repositories/auth/reset_email_repository.dart';

class ResetEmailViewModel extends ChangeNotifier {
  final ResetEmailRepository _repository;
  ResetEmailViewModel(this._repository);

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  Future<void> resetPasswordByEmail(String email) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();
    final result = await _repository.resetPasswordByEmail(email);
    result.fold(
          (error) {
        errorMessage = error.toString();
      },
          (message) {
        successMessage = message;
      },
    );
    isLoading = false;
    notifyListeners();
  }
}
