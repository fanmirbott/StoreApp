import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/status.dart';
import '../../../../data/repositories/notification_repository.dart';
import 'notification_state.dart';
import 'package:flutter/material.dart';
part 'notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required NotificationRepository notifRepo,
  })  : _notifRepo = notifRepo,
        super(NotificationState.initial()) {
    on<NotificationLoading>(_onNotificationLoading);
    add(NotificationLoading());
  }

  final NotificationRepository _notifRepo;

  Future<void> _onNotificationLoading(
      NotificationLoading event,
      Emitter<NotificationState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _notifRepo.getNotification();
    result.fold(
          (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
          (value) =>
          emit(state.copyWith(status: Status.success, notifications: value)),
    );
  }
}
