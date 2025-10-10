import 'package:flutter/cupertino.dart';
import 'package:storeapp/data/models/categories_model.dart';
import 'package:storeapp/data/repositories/categories_repository.dart';

class CategoriesViewModel extends ChangeNotifier {
  final ICategories _repository;

  CategoriesViewModel({required ICategories repository})
      : _repository = repository;

  bool isLoading = false;
  List<CategoriesModel> categories = [];
  String? errorMessage;
  Future<void> getCategories() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.getCategories();

    result.fold(
          (error) {
        categories = [];
        errorMessage = error.toString();
      },
          (data) {
        categories = data;
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void build(){
    final categories = _repository.getCategories();
  }
}