
part of 'update_user_bloc.dart';

sealed class UpdateUserEvent {}

final class UpdateUserStarted extends UpdateUserEvent {
  final UserModel user;

  UpdateUserStarted({required this.user});
}