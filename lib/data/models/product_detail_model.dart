class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final int price;
  final bool isLiked;
  final List<ProductImage> productImages;
  final List<ProductSize> productSizes;
  final int reviewsCount;
  final double rating;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isLiked,
    required this.productImages,
    required this.productSizes,
    required this.reviewsCount,
    required this.rating,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      isLiked: json['isLiked'] as bool,
      productImages: (json['productImages'] as List<dynamic>)
          .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      productSizes: (json['productSizes'] as List<dynamic>)
          .map((e) => ProductSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewsCount: json['reviewsCount'] as int,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'isLiked': isLiked,
      'productImages': productImages.map((e) => e.toJson()).toList(),
      'productSizes': productSizes.map((e) => e.toJson()).toList(),
      'reviewsCount': reviewsCount,
      'rating': rating,
    };
  }

  @override
  String toString() {
    return 'ProductDetailModel{id: $id, title: $title, description: $description, price: $price, isLiked: $isLiked, productImages: $productImages, productSizes: $productSizes, reviewsCount: $reviewsCount, rating: $rating}';
  }
}

class ProductImage {
  final int id;
  final String image;

  ProductImage({
    required this.id,
    required this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] as int,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'ProductImage{id: $id, image: $image}';
  }
}

class ProductSize {
  final int id;
  final String title;

  ProductSize({
    required this.id,
    required this.title,
  });

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  @override
  String toString() {
    return 'ProductSize{id: $id, title: $title}';
  }
}
