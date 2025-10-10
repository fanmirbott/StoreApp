import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_create_event.freezed.dart';

@freezed
abstract class CardCreateEvent with _$CardCreateEvent {
  const factory CardCreateEvent.create({
    required String cardNumber,
    required String expiryDate,
    required String securityCode,
  }) = _Create;
}
