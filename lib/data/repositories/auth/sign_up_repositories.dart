

import '../../../core/client.dart';
import '../../../core/utils/result.dart';

class SignUpRepositories {
  final ApiClient _client;
  SignUpRepositories({required ApiClient client}) : _client = client;

  Future<Result<String>> signUp(String fullName ,String email, String password) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/register',
      data: {'fullName' : fullName ,'email': email, 'password': password},
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
