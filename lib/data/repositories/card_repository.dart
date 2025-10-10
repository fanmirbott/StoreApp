import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';
import 'package:storeapp/data/models/card_model.dart';

class CardRepository {
  final ApiClient _client;

  CardRepository({required ApiClient client}) : _client = client;

  Future<Result<Map<String, dynamic>>> postCard({
    required String cardNumber,
    required String expiryDate,
    required String securityCode,
  }) async {
    final result = await _client.post<Map<String, dynamic>>(
      '/cards/create',
      data: {
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'securityCode': securityCode,
      },
    );

    return result.fold(
      (error) => Result.error(error),
      (value) => Result.ok(value),
    );
  }

  Future<Result<List<CardModel>>> getCards() async {
    final result = await _client.get<List<dynamic>>('/cards/list');

    return result.fold(
      (error) => Result.error(error),
      (data) {
        try {
          final cards = data.map((e) => CardModel.fromJson(e)).toList();
          return Result.ok(cards);
        } catch (e) {
          return Result.error(Exception(e));
        }
      },
    );
  }

  Future<Result<void>> deleteCard(int cardId) async {
    final result = await _client.delete<dynamic>('/cards/delete/$cardId');
    return result.fold(
      (error) => Result.error(error),
      (_) => Result.ok(null),
    );
  }
}
