class SavedProductModel {
  final int id;
  final int categoryId;
  final String image;
  final String title;
  final int price;
  final bool isLiked;
  final int discount;

  const SavedProductModel({
    required this.id,
    required this.categoryId,
    required this.image,
    required this.title,
    required this.price,
    required this.isLiked,
    required this.discount,
  });

  factory SavedProductModel.fromJson(Map<String, dynamic> json) {
    return SavedProductModel(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int,
      image: json['image'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      isLiked: json['isLiked'] as bool,
      discount: json['discount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'image': image,
      'title': title,
      'price': price,
      'isLiked': isLiked,
      'discount': discount,
    };
  }

}
