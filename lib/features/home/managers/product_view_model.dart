import 'package:flutter/cupertino.dart';
import 'package:storeapp/data/models/product_model.dart';
import 'package:storeapp/data/repositories/products/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductViewModel({required ProductRepository repository})
      : _repository = repository;

  bool isLoading = false;
  List<ProductModel> products = [];
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
}
