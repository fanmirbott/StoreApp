import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/orders_model.dart';

class OrdersRepository {
  final ApiClient _client;

  OrdersRepository({required ApiClient client}) : _client = client;

  Future<Result<List<OrderGetModel>>> getOrder() async {
    final result = await _client.get<List<dynamic>>('/orders/list');

    return result.fold((error) => Result.error(error), (data) {
      try {
        final orders = data
            .map((e) => OrderGetModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.ok(orders);
      } catch (e) {
        return Result.error(Exception('Parsing error: $e'));
      }
    });
  }
  Future<Result<void>> createOrder(OrderPostModel order) async {
    final result = await _client.post(
      '/orders/create',
      data: order.toJson(),
    );

    return result.fold(
          (error) => Result.error(error),
          (_) => Result.ok(null),
    );
  }

  Future<Result<void>> deleteOrder(int orderId) async {
    final result = await _client.delete('/orders/delete/$orderId');

    return result.fold(
          (error) => Result.error(error),
          (_) => Result.ok(null),
    );
  }
}
