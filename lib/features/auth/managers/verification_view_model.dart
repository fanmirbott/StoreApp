import 'package:flutter/foundation.dart';

import '../../../data/repositories/verification_repository.dart';

class VerifyResetCodeViewModel extends ChangeNotifier {
  final VerifyResetCodeRepository _repository;

  VerifyResetCodeViewModel(this._repository);

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  Future<void> verifyResetCode(String email, String code) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    final result = await _repository.verifyResetCode(email, code);

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
