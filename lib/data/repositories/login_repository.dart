import '../../core/client.dart';
import '../../core/utils/result.dart';

class LoginRepository {
  final ApiClient _client;
  LoginRepository({required ApiClient client}) : _client = client;

  Future<Result<String>> login(String login, String password) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'login': login, 'password': password},
    );

    return response.fold(
          (error) => Result.error(error),
          (data) {
        final token = data['accessToken'] as String?;
        if (token != null && token.isNotEmpty) {
          return Result.ok(token);
        } else {
          return Result.error(Exception("Token topilmadi"));
        }
      },
    );
  }
}
