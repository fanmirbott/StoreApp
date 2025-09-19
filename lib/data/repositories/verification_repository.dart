import '../../core/client.dart';
import '../../core/utils/result.dart';

class VerifyResetCodeRepository {
  final ApiClient _client;
  VerifyResetCodeRepository({required ApiClient client}) : _client = client;

  Future<Result<String>> verifyResetCode(String email, String code) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/reset-password/verify',
      data: {
        'email': email,
        'code': code,
      },
    );

    return response.fold(
          (error) => Result.error(error),
          (data) {
        final message = data['message'] as String?;
        if (message != null && message.isNotEmpty) {
          return Result.ok(message);
        } else {
          return Result.error(Exception("Serverdan xabar kelmadi"));
        }
      },
    );
  }
}
