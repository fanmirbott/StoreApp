import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/saved_model.dart';

part 'saved_state.freezed.dart';

@freezed
abstract class SavedProductsState with _$SavedProductsState {
  const factory SavedProductsState({
    required Status status,
    String? errorMessage,
    required List<SavedProductModel> savedProducts,
  }) = _SavedProductsState;

  factory SavedProductsState.initial() => SavedProductsState(
    status: Status.loading,
    errorMessage: null,
    savedProducts: [],
  );
}
