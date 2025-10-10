import '../../../core/client.dart';
import '../../../core/utils/result.dart';
import '../../models/user_model.dart';

class UserRepository {
  final ApiClient _client;

  UserRepository({required ApiClient client}) : _client = client;

  Future<Result<UserModel>> getUser() async {
    final result = await _client.get<Map<String, dynamic>>('/auth/me');
    return result.fold(
          (error) => Result.error(error),
          (value) => Result.ok(UserModel.fromJson(value)),
    );
  }
  Future<Result<UserModel>> updateUser(UserModel user) async {
    final result = await _client.patch<Map<String, dynamic>>(
      '/auth/update',
      data: user.toJson(),
    );

    return result.fold(
          (error) => Result.error(error),
          (value) => Result.ok(UserModel.fromJson(value)),
    );
  }


}
