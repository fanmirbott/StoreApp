import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/result.dart';

class CardCreateRepository {
  final ApiClient _client;

  CardCreateRepository({required ApiClient client}) : _client = client;

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


}
