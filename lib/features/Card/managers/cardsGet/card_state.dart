import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';

import '../../../../data/models/card_model.dart';
part 'card_state.freezed.dart';

@freezed
abstract class CardState with _$CardState {
  const factory CardState({
    required Status status,
    String? errorMessage,
    required List<CardModel> cards,
  }) = _CardState;

  factory CardState.initial() => const CardState(
    status: Status.loading,
    errorMessage: null,
    cards: [],
  );
}
