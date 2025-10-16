
sealed class CardEvent {}

final class CardLoading extends CardEvent {}

final class CardCreate extends CardEvent {
  final String cardNumber;
  final String expiryDate;
  final String securityCode;

  CardCreate({
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
  });
}

final class CardDelete extends CardEvent {
  final int cardId;

  CardDelete({required this.cardId});
}