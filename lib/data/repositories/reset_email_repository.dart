import '../../core/client.dart';
import '../../core/utils/result.dart';

class ResetEmailRepository {
  final ApiClient _client;
  ResetEmailRepository({required ApiClient client}) : _client = client;
  Future<Result<String>> resetPasswordByEmail(String email) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/reset-password/email',
      data: {'email': email},
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
