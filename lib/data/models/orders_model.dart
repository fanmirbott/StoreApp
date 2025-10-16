class OrderGetModel {
  final int id;
  final int productId;
  final String title;
  final String image;
  final String size;
  final int price;
  final String status;
  final double rating;

  OrderGetModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.image,
    required this.size,
    required this.price,
    required this.status,
    required this.rating,
  });

  factory OrderGetModel.fromJson(Map<String, dynamic> json) {
    return OrderGetModel(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      size: json['size'] ?? '',
      price: json['price'] ?? 0,
      status: json['status'] ?? '',
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
    );
  }

}

class OrderPostModel {
  final int addressId;
  final String paymentMethod;
  final int cardId;

  OrderPostModel({
    required this.addressId,
    required this.paymentMethod,
    required this.cardId,
  });

  factory OrderPostModel.fromJson(Map<String, dynamic> json) {
    return OrderPostModel(
      addressId: json['addressId'] ?? 0,
      paymentMethod: json['paymentMethod'] ?? '',
      cardId: json['cardId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressId': addressId,
      'paymentMethod': paymentMethod,
      'cardId': cardId,
    };
  }
}
