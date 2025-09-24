import 'package:flutter/material.dart';
import 'package:storeapp/data/models/product_model.dart';
import 'package:storeapp/data/repositories/saved_repository.dart';

class SavedViewModel extends ChangeNotifier {
  final SavedRepository _repository;

  SavedViewModel({required SavedRepository repository})
      : _repository = repository;

  bool isLoading = false;
  String? errorMessage;

  // 🔹 Save qilish
  Future<void> saveProduct(ProductModel product) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.saveProduct(product.id);

    result.fold(
          (error) {
        errorMessage = error.toString();
      },
          (_) {
        product.isLiked = true;
      },
    );

    isLoading = false;
    notifyListeners();
  }

  // 🔹 Unsave qilish
  Future<void> unSaveProduct(ProductModel product) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.unSaveProduct(product.id);

    result.fold(
          (error) {
        errorMessage = error.toString();
      },
          (_) {
        product.isLiked = false;
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
