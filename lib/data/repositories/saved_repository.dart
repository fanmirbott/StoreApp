import 'package:storeapp/core/client.dart';
import 'package:dartz/dartz.dart';

class SavedRepository {
  final ApiClient client;
  SavedRepository({required this.client});

  // 🔹 Save qilish (like)
  Future<Either<Exception, void>> saveProduct(int productId) async {
    try {
      await client.post("/auth/save/$productId");
      return const Right(null);
    } catch (e) {
      return Left(Exception("Saqlashda xato: $e"));
    }
  }

  // 🔹 Unsave qilish (unlike)
  Future<Either<Exception, void>> unSaveProduct(int productId) async {
    try {
      await client.post("/auth/unsave/$productId");
      return const Right(null);
    } catch (e) {
      return Left(Exception("O‘chirishda xato: $e"));
    }
  }
}
