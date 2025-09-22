import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/product_detail_model.dart';

class ProductDetailRepository {
  final ApiClient _client;

  ProductDetailRepository({required ApiClient client}) : _client = client;

  Future<Result<List<ProductDetailModel>>> getProductDetail() async {
    final result = await _client.get<List<dynamic>>('/products/detail/1');
    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          final products = (data)
              .map((x) => ProductDetailModel.fromJson(x as Map<String, dynamic>))
              .toList();
          return Result.ok(products);
        } catch (e) {
          return Result.error(Exception("Kategoriya parse qilishda xato: $e"));
        }
      },
    );
  }
}
