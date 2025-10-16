import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/cart_item_model.dart';
import 'package:storeapp/data/repositories/cart_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(CartState.initial()) {
    on<CartLoading>(_onCartLoading);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemDeleted>(_onCartItemDeleted);
  }

  Future<void> _onCartLoading(
    CartLoading event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));

    final result = await _cartRepository.getCartItems();

    result.fold(
      (error) => emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      ),
      (value) => emit(
        state.copyWith(
          status: Status.success,
          cart: value,
        ),
      ),
    );
  }

  Future<void> _onCartItemAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));

    final result = await _cartRepository.addItemToCart(
      productId: event.productId,
      sizeId: event.sizeId,
    );

    await result.fold(
      (error) async {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      },
      (value) async {
        final updated = await _cartRepository.getCartItems();

        await updated.fold(
          (err) async {
            emit(
              state.copyWith(
                status: Status.error,
                errorMessage: err.toString(),
              ),
            );
          },
          (cart) async {
            emit(
              state.copyWith(
                status: Status.success,
                cart: cart,
                lastAddedItem: value,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onCartItemDeleted(
    CartItemDeleted event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));
    final result = await _cartRepository.deleteItemFromCart(event.productId);
    await result.fold(
      (error) async {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      },
      (_) async {
        add(CartLoading());
      },
    );
  }
}
