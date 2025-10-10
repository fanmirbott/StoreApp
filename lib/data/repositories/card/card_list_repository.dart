import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';

import '../../models/card_model.dart';

class CardListRepository {
  final ApiClient _client;

  CardListRepository({required ApiClient client}) : _client = client;

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
}
