import 'package:flutter/cupertino.dart';
import 'package:storeapp/data/models/product_model.dart';
import 'package:storeapp/data/repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductViewModel({required ProductRepository repository})
      : _repository = repository;

  bool isLoading = false;
  List<ProductModel> products = [];
  List<ProductModel> savedProducts = [];
  String? errorMessage;

  Future<void> getProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.getProducts();

    result.fold(
          (error) {
        products = [];
        errorMessage = error.toString();
      },
          (data) {
        products = data;
      },
    );

    isLoading = false;
    notifyListeners();
  }

  // 🔹 Saqlangan mahsulotlarni olish
  Future<void> getSavedProducts() async {
    final result = await _repository.getSavedProducts();

    result.fold(
          (error) {
        savedProducts = [];
        errorMessage = error.toString();
      },
          (data) {
        savedProducts = data;
      },
    );

    notifyListeners();
  }

  // 🔹 Like bosilganda mahsulotni saqlash
  Future<void> toggleSave(int productId) async {
    final result = await _repository.saveProduct(productId);

    result.fold(
          (error) {
        errorMessage = error.toString();
      },
          (_) async {
        // Saqlanganlar ro‘yxatini qayta olish
        await getSavedProducts();
      },
    );

    notifyListeners();
  }

  // 🔹 Mahsulot saqlanganligini tekshirish
  bool isProductSaved(int productId) {
    return savedProducts.any((p) => p.id == productId);
  }
}
