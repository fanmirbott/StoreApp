import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/data/models/notification_model.dart';
import 'package:storeapp/core/utils/status.dart';
part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState({
    required Status status,
    String? errorMessage,
    required List<NotificationModel> notifications,
  }) = _NotificationState;

  factory NotificationState.initial() => NotificationState(
    status: Status.loading,
    errorMessage: null,
    notifications: [],
  );
}
