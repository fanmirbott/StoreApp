import '../../core/client.dart';
import '../../core/utils/result.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final ApiClient _client;

  NotificationRepository({required ApiClient client}) : _client = client;

  Future<Result<List<NotificationModel>>> getNotification() async {
    final result = await _client.get<List<dynamic>>('/notifications/list');
    return result.fold(
          (error) => Result.error(error),
          (value) => Result.ok(
        value.map((e) => NotificationModel.fromJson(e)).toList(),
      ),
    );
  }
}
