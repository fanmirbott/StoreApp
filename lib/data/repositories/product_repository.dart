import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/product_model.dart';
import '../models/saved_model.dart';

class ProductRepository {
  final ApiClient _client;

  ProductRepository({required ApiClient client}) : _client = client;

  Future<Result<List<ProductModel>>> getProducts({
    int? categoryId,
    String? title,
    double? minPrice,
    double? maxPrice,
    int? orderBy,
    int? sizeId,
  }) async {
    final Map<String, dynamic> queryParams = {};

    if (categoryId != null && categoryId != 0) {
      queryParams['CategoryId'] = categoryId.toString();
    }

    if (title != null && title.isNotEmpty) {
      queryParams['Title'] = title;
    }

    if (minPrice != null) {
      queryParams['MinPrice'] = minPrice.toInt().toString();
    }

    if (maxPrice != null) {
      queryParams['MaxPrice'] = maxPrice.toInt().toString();
    }

    if (orderBy != null) {
      queryParams['OrderBy'] = orderBy.toString();
    }

    if (sizeId != null) {
      queryParams['SizeId'] = sizeId.toString();
    }

    final result = await _client.get<List<dynamic>>(
      '/products/list',
      queryParams: queryParams.isNotEmpty ? queryParams : null,
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          final products = data
              .map((x) => ProductModel.fromJson(x as Map<String, dynamic>))
              .toList();
          return Result.ok(products);
        } catch (e) {
          return Result.error(
            Exception("Mahsulotlarni parse qilishda xato: $e"),
          );
        }
      },
    );
  }

  Future<Result<List<SavedProductModel>>> getSavedProducts() async {
    final result = await _client.get<List<dynamic>>(
      '/products/saved-products',
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          final products = data
              .map((e) => SavedProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Result.ok(products);
        } catch (e) {
          return Result.error(
            Exception("Saqlangan mahsulotlarni parse qilishda xato: $e"),
          );
        }
      },
    );
  }
}
