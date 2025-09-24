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
    // start
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.getProducts();

    result.fold(
      // 👇 LEFT: xato holati
          (error) {
        products = [];
        errorMessage = error.toString();
        isLoading = false;
        notifyListeners();
      },
      // 👇 RIGHT: muvaffaqiyatli holat
          (data) {
        products = data;
        isLoading = false;
        notifyListeners();
      },
    );
  }
}
