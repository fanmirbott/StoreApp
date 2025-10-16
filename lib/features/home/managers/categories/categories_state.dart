import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/categories_model.dart';
part 'categories_state.freezed.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    required Status status,
    String? errorMessage,
    required List<CategoriesModel> categories,
  }) = _CategoriesState;

  factory CategoriesState.initial() => const CategoriesState(
    status: Status.loading,
    errorMessage: null,
    categories: [],
  );
}
