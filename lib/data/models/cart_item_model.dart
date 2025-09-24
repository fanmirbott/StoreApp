class CartItemModel {
  final int id;
  final int productId;
  final String title;
  final String size;
  final int price;
  final String image;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.size,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['productId'],
      title: json['title'],
      size: json['size'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}

class CartResponseModel {
  final List<CartItemModel> items;
  final int subTotal;
  final int vat;
  final int shippingFee;
  final int total;

  CartResponseModel({
    required this.items,
    required this.subTotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
      subTotal: json['subTotal'],
      vat: json['vat'],
      shippingFee: json['shippingFee'],
      total: json['total'],
    );
  }
}
