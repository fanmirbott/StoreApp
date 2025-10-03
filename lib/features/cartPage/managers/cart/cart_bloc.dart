import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/status.dart';
import '../../../../data/repositories/products/cart_repository.dart';
import 'cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(CartState.initial()) {
    on<CartLoading>(_onCartLoading);
  }

  Future<void> _onCartLoading(
      CartLoading event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _cartRepository.getCartItem();

    result.fold(
          (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      },
          (value) {
        emit(
          state.copyWith(
            status: Status.success,
            cart: value,
          ),
        );
      },
    );
  }
}
