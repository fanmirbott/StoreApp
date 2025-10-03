import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';

import '../../../../data/models/me_model.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    required Status status,
    String? errorMessage,
    UserModel? user,
  }) = _UserState;

  factory UserState.initial() => UserState(
    status: Status.loading,
    errorMessage: null,
    user: null,
  );
}
