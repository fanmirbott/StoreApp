import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <--- Provider import qilinishi kerak
import 'package:storeapp/data/models/product_model.dart';
import 'package:storeapp/data/repositories/saved_repository.dart';
import 'package:storeapp/features/home/managers/product_view_model.dart';
class SavedViewModel extends ChangeNotifier {
  final SavedRepository _repository;

  SavedViewModel({required SavedRepository repository})
      : _repository = repository;

  bool isLoading = false;
  String? errorMessage;

  Future<void> saveProduct(ProductModel product, BuildContext context) async {
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

        Provider.of<ProductViewModel>(context, listen: false)
            .updateProductLikeStatus(product.id, true);
      },
    );

    isLoading = false;
    notifyListeners();
  }
  Future<void> unSaveProduct(ProductModel product, BuildContext context) async {
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
        Provider.of<ProductViewModel>(context, listen: false)
            .updateProductLikeStatus(product.id, false);
      },
    );

    isLoading = false;
    notifyListeners();
  }
}