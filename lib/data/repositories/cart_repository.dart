import 'dart:convert';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/cart_item_model.dart';

class CartRepository {
  final ApiClient _client;

  CartRepository({required ApiClient client}) : _client = client;

  Future<Result<CartResponseModel>> getCartItems() async {
    final result = await _client.get<Map<String, dynamic>>(
      '/cart-items',
    );
    return result.fold(
      (error) => Result.error(error),
      (value) => Result.ok(CartResponseModel.fromJson(value)),
    );
  }

  Future<Result<CartItemModel>> addItemToCart({
    required int productId,
    required int sizeId,
  }) async {
    final result = await _client.post<dynamic>(
      '/cart-items',
      data: {"productId": productId, "sizeId": sizeId},
    );

    return result.fold(
      (error) => Result.error(error),
      (value) {
        if (value == null || (value is String && value.trim().isEmpty)) {
          final emptyModel = CartItemModel(
            id: 0,
            productId: productId,
            title: 'Successfully added',
            image: '',
            price: 0,
            size: '',
            quantity: 1,
          );
          return Result.ok(emptyModel);
        }

        final data = (value is String) ? json.decode(value) : value;
        return Result.ok(CartItemModel.fromJson(data['data'] ?? data));
      },
    );
  }

  Future<Result<void>> deleteItemFromCart(int productId) async {
    final result = await _client.delete<dynamic>('/cart-items/$productId');
    return result.fold(
      (error) => Result.error(error),
      (_) => Result.ok(null),
    );
  }
}
