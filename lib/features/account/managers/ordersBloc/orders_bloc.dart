import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/orders_model.dart';
import 'package:storeapp/data/repositories/orders_repository.dart';

import 'orders_state.dart';
part 'orders_event.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _ordersRepo;

  OrdersBloc({required OrdersRepository ordersRepo})
      : _ordersRepo = ordersRepo,
        super(OrdersState.initial()) {
    on<OrdersGet>(_onGetOrders);
    on<OrdersCreate>(_onCreateOrder);
    on<OrdersDelete>(_onDeleteOrder);
  }

  Future<void> _onGetOrders(
      OrdersGet event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _ordersRepo.getOrder();
    result.fold(
          (error) => emit(state.copyWith(
        status: Status.error,
        errorMessage: error.toString(),
      )),
          (data) => emit(state.copyWith(
        status: Status.success,
        orders: data ?? [],
            errorMessage: null
      )),
    );
  }

  Future<void> _onCreateOrder(
      OrdersCreate event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _ordersRepo.createOrder(event.order);
    result.fold(
          (error) => emit(state.copyWith(
        status: Status.error,
        errorMessage: error.toString(),
      )),
          (_) => add(OrdersGet()),
    );
  }

  Future<void> _onDeleteOrder(
      OrdersDelete event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _ordersRepo.deleteOrder(event.orderId);
    result.fold(
          (error) => emit(state.copyWith(
        status: Status.error,
        errorMessage: error.toString(),
      )),
          (_) {
        final updatedOrders = List<OrderGetModel>.from(state.orders)
          ..removeWhere((order) => order.id == event.orderId);
        emit(state.copyWith(
          status: Status.success,
          orders: updatedOrders,
        ));
      },
    );
  }
}
