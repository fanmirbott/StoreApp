
part of 'saved_bloc.dart';

sealed class SavedProductsEvent {}

final class FetchSavedProducts extends SavedProductsEvent {}

final class SaveProductEvent extends SavedProductsEvent {
  final int productId;
  SaveProductEvent(this.productId);
}

final class UnSaveProductEvent extends SavedProductsEvent {
  final int productId;
  UnSaveProductEvent(this.productId);
}
