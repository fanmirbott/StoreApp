part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.cartLoading() = CartLoading;
  const factory CartEvent.cartItemAdded({
    required int productId,
    required int sizeId,
  }) = CartItemAdded;
  const factory CartEvent.cartItemDeleted({
    required int productId,
  }) = CartItemDeleted;
}