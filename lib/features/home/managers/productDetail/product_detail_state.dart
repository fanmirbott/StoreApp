import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/status.dart';
import '../../../../data/models/product_detail_model.dart';

part 'product_detail_state.freezed.dart';

@freezed
abstract class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    required Status status,
    String? errorMessage,
    required ProductDetailModel? productDetails,
  }) = _ProductDetailState;

  factory ProductDetailState.initial() => ProductDetailState(
    status: Status.loading,
    errorMessage: null,
    productDetails: null,
  );
}
