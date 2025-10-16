import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';

part 'saved_state.freezed.dart';

@freezed
abstract class SavedState with _$SavedState {
  const factory SavedState({
    required Status status,
    String? errorMessage,
  }) = _SavedState;

  factory SavedState.initial() => const SavedState(
    status: Status.initial,
    errorMessage: null,

  );
}
