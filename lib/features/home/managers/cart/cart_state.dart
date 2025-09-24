import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';

import '../../../../data/models/cart_item_model.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
   factory CartState({
    required Status status,
    String? errorMessage,
    required CartResponseModel? cart,
  }) = _CartState;

  factory CartState.initial() => CartState(
    status: Status.loading,
    errorMessage: null,
    cart: null,
  );
}
