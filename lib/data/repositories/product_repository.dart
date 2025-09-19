import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/product_model.dart';

class ProductRepository {
  final ApiClient _client;

  ProductRepository({required ApiClient client}) : _client = client;

  Future<Result<List<ProductModel>>> getProducts() async {
    final result = await _client.get<List<dynamic>>(
      '/products/list',
    );
    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          final products = (data)
              .map((x) => ProductModel.fromJson(x as Map<String, dynamic>))
              .toList();
          return Result.ok(products);
        } catch (e) {
          return Result.error(Exception("Kategoriya parse qilishda xato: $e"));
        }
      },
    );
  }

  Future<Result<void>> saveProduct(int productId) async {
    final result = await _client.post<Map<String, dynamic>>(
      '/products/saved-products',
      data: {"product_id": productId},
    );

    return result.fold(
          (error) => Result.error(error),
          (data) => Result.ok(null),
    );
  }

  Future<Result<List<ProductModel>>> getSavedProducts() async {
    final result = await _client.get<List<dynamic>>(
      '/products/saved-products',
    );
    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          final products = (data)
              .map((x) => ProductModel.fromJson(x as Map<String, dynamic>))
              .toList();
          return Result.ok(products);
        } catch (e) {
          return Result.error(Exception("Saved product parse qilishda xato: $e"));
        }
      },
    );
  }
}
