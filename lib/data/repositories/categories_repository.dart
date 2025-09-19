import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/categories_model.dart';

class CategoryRepository {
  final ApiClient _client;

  CategoryRepository({required ApiClient client}
      ) : _client = client;

  Future<Result<List<CategoriesModel>>> getCategories() async {
    final result = await _client.get<List<dynamic>>(
      '/categories/list',
    );
    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          final categories = (data)
              .map((x) => CategoriesModel.fromJson(x as Map<String, dynamic>))
              .toList();
          return Result.ok(categories);
        } catch (e) {
          return Result.error(Exception("Kategoriya parse qilishda xato: $e"));
        }
      },
    );
  }
}
