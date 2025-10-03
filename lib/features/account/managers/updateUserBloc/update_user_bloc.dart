import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/features/account/managers/updateUserBloc/update_user_event.dart';
import 'package:storeapp/features/account/managers/updateUserBloc/update_user_state.dart';
import '../../../../core/utils/status.dart';
import '../../../../data/repositories/auth/user_repository.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRepository userRepository;

  UpdateUserBloc(this.userRepository)
      : super(UpdateUserState(status: Status.loading)) {
    on<UpdateUserRequested>(_onUpdateUserRequested);
  }

  Future<void> _onUpdateUserRequested(
      UpdateUserRequested event, Emitter<UpdateUserState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await userRepository.updateUser(event.user);

    result.fold(
          (error) {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      },
          (updatedUser) {
        emit(state.copyWith(
          status: Status.success,
          user: updatedUser,
        ));
      },
    );
  }
}
