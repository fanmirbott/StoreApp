import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_create_state.freezed.dart';

@freezed
class CardCreateState with _$CardCreateState {
  const factory CardCreateState.initial() = _Initial;
  const factory CardCreateState.loading() = _Loading;
  const factory CardCreateState.success(Map<String, dynamic> data) = _Success;
  const factory CardCreateState.failure(String error) = _Failure;
}
