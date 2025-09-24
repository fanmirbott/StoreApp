import 'package:storeapp/data/models/cart_item_model.dart';
import '../../../core/client.dart';
import '../../../core/utils/result.dart';

class CartRepository {
  final ApiClient _client;

  CartRepository({required ApiClient client}) : _client = client;

  Future<Result<CartResponseModel>> getCartItem() async {
    final result = await _client.get<Map<String, dynamic>>('/my-cart/my-cart-items');
    return result.fold(
          (error) => Result.error(error),
          (value) {
        final cart = CartResponseModel.fromJson(value);
        return Result.ok(cart);
      },
    );
  }
}

