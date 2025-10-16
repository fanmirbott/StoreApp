import '../../core/client.dart';
import '../../core/utils/result.dart';
import '../models/card_model.dart';

class CardRepository {
  final ApiClient _client;

  CardRepository({required ApiClient client}) : _client = client;

  Future<Result<List<CardModel>>> getCards() async {
    final result = await _client.get<List<dynamic>>('/cards');

    return result.fold(
          (error) => Result.error(error),
          (data) {
       try {
          final cards = data
              .map((e) => CardModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Result.ok(cards);
        } catch (e) {
          return Result.error(Exception('Parsing error: $e'));
        }
      },
    );
  }

  Future<Result<CardModel>> postCard({
    required String cardNumber,
    required String expiryDate,
    required String securityCode,
  }) async {
    final data = {
      "cardNumber": cardNumber,
      "expiryDate": expiryDate,
      "securityCode": securityCode,
    };

    final result = await _client.post<Map<String, dynamic>>(
      '/cards',
      data: data,
    );

    return result.fold(
          (error) => Result.error(error),
          (data) => Result.ok(CardModel.fromJson(data)),
    );
  }


  Future<Result<void>> deleteCard(int id) async {
    final result = await _client.delete('/cards/$id');

    return result.fold(
          (error) => Result.error(error),
          (_) => Result.ok(null),
    );
  }
}
