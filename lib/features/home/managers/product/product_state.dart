import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/product_model.dart';

part 'product_state.freezed.dart';

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState({
    required Status status,
    String? errorMessage,
    required List<ProductModel> products,
  }) = _ProductState;

  factory ProductState.initial() => const ProductState(
    status: Status.loading,
    errorMessage: null,
    products: [],
  );
}
