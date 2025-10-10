class CartAddModel {
  final int productId;
  final int sizeId;

  CartAddModel({
    required this.productId,
    required this.sizeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'sizeId': sizeId,
    };
  }
}