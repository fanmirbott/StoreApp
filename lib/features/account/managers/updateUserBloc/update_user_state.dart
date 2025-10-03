import '../../../../core/utils/status.dart';
import '../../../../data/models/me_model.dart';

class UpdateUserState {
  final Status status;
  final String? errorMessage;
  final UserModel? user;

  UpdateUserState({
    required this.status,
    this.errorMessage,
    this.user,
  });

  UpdateUserState copyWith({
    Status? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return UpdateUserState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
