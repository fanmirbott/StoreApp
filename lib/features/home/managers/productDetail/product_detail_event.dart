part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent {}

final class ProductDetailLoading extends ProductDetailEvent {
  final int id;

  ProductDetailLoading({required this.id});
}
