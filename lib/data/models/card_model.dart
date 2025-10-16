class CardModel {
  final int id;
  final String cardNumber;
  final String expiryDate;
  final String securityCode;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] ?? 0,
      cardNumber: json['cardNumber'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      securityCode: json['securityCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'securityCode': securityCode,
    };
  }
}
