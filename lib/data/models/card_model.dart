class CardModel {
  final int id;
  final String cardNumber;

  CardModel({
    required this.id,
    required this.cardNumber,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] ?? 0,
      cardNumber: json['cardNumber'] ?? '',
    );
  }
}
