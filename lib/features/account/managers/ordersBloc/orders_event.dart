part of 'orders_bloc.dart';

abstract class OrdersEvent {}

class OrdersGet extends OrdersEvent {}
class OrdersCreate extends OrdersEvent {
  final OrderPostModel order;
  OrdersCreate({required this.order});
}

class OrdersDelete extends OrdersEvent {
  final int orderId;
  OrdersDelete({required this.orderId});
}
