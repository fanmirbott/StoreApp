import '../../../../data/models/me_model.dart';

abstract class UpdateUserEvent {}

class UpdateUserRequested extends UpdateUserEvent {
  final UserModel user;
  UpdateUserRequested(this.user);
}
