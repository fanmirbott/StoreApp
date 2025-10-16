import '../../../core/client.dart';
import '../../../core/utils/result.dart';
import '../../../core/utils/secure_storege.dart';

class AuthRepository {
  final ApiClient _client;
  AuthRepository({required ApiClient client}) : _client = client;

  Future<Result<String>> login(String email, String password) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'login': email, 'password': password},
    );

    return response.fold(
          (error) => Result.error(error),
          (data) async {
        final token = data['accessToken'] as String?;
        if (token != null && token.isNotEmpty) {
          await AuthStorage.saveToken(token);
          return Result.ok(token);
        } else {
          return Result.error(Exception("Token topilmadi"));
        }
      },
    );
  }

  Future<Result<String>> signUp(
      String fullName, String email, String password) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/register',
      data: {'fullName': fullName, 'email': email, 'password': password},
    );

    return response.fold(
          (error) => Result.error(error),
          (data) async {
        final token = data['accessToken'] as String?;
        if (token != null && token.isNotEmpty) {
          await AuthStorage.saveToken(token);
          return Result.ok(token);
        } else {
          return Result.error(Exception("Token topilmadi"));
        }
      },
    );
  }

  Future<void> logout() async {
    await AuthStorage.deleteToken();
  }
}
