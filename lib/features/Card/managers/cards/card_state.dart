import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/data/models/card_model.dart';
import 'package:storeapp/core/utils/status.dart';

part 'card_state.freezed.dart';

@freezed
abstract class CardState with _$CardState {
  const factory CardState({
    required Status status,
    required Status createStatus,
    required Status deleteStatus,
    String? errorMessage,
    required List<CardModel> cards,
  }) = _CardState;

  factory CardState.initial() => CardState(
    status: Status.loading,
    createStatus: Status.success,
    deleteStatus: Status.success,
    errorMessage: null,
    cards: [],
  );
}