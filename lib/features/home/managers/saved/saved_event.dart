part of 'saved_bloc.dart';

sealed class SavedEvent {}

final class SaveProductEvent extends SavedEvent {
  final ProductModel product;
  SaveProductEvent(this.product);
}

final class UnSaveProductEvent extends SavedEvent {
  final ProductModel product;
  UnSaveProductEvent(this.product);
}
