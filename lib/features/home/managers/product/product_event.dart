part of 'product_bloc.dart';

sealed class ProductEvent {}

final class ProductLoading extends ProductEvent {
  final int? categoryId;
  final String? title;
  final double? minPrice;
  final double? maxPrice;
  final int? orderBy;
  final int? sizeId;

  ProductLoading({
    this.categoryId,
    this.title,
    this.minPrice,
    this.maxPrice,
    this.orderBy,
    this.sizeId,
  });
}

final class UpdateProductLike extends ProductEvent {
  final int productId;
  final bool isLiked;

  UpdateProductLike({
    required this.productId,
    required this.isLiked,
  });
}
