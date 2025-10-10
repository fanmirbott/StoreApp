import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';
import '../../../../data/models/user_model.dart';
part 'update_user_state.freezed.dart';

@freezed
abstract class UpdateUserState with _$UpdateUserState {
  const factory UpdateUserState({
    required Status status,
    String? errorMessage,
    UserModel? updatedUser,
  }) = _UpdateUserState;
  factory UpdateUserState.initial() => const UpdateUserState(
    status: Status.success,
    errorMessage: null,
    updatedUser: null,
  );
}