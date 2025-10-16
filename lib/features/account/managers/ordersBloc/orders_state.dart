import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/status.dart';
import '../../../../data/models/orders_model.dart';

part 'orders_state.freezed.dart';

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState({
    required List<OrderGetModel> orders,
    required Status status,
    String? errorMessage,
  }) = _OrdersState;

  factory OrdersState.initial() => OrdersState(
    orders: [],
    status: Status.initial,
    errorMessage: null,
  );
}