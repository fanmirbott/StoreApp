part of 'cart_bloc.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    required Status status,
    String? errorMessage,
    CartResponseModel? cart,
    CartItemModel? lastAddedItem,
  }) = _CartState;

  factory CartState.initial() => const CartState(
    status: Status.loading,
    errorMessage: null,
    cart: null,
    lastAddedItem: null,
  );
}
