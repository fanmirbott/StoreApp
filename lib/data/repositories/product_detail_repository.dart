import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/product_detail_model.dart';

class ProductDetailRepository {
  final ApiClient _client;

  ProductDetailRepository({required ApiClient client}) : _client = client;

  Future<Result<ProductDetailModel>> getProductDetail(int id) async {
    final result = await _client.get<Map<String, dynamic>>(
      '/products/detail/$id',
    );

    return result.fold(
      (error) => Result.error(error),
      (data) {
        try {
          return Result.ok(ProductDetailModel.fromJson(data));
        } catch (e, stackTrace) {
          return Result.error(
            Exception("Product parse qilishda xato: $e\n$stackTrace"),
          );
        }
      },
    );
  }
}
