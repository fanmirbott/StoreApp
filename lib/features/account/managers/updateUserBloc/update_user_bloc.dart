import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import '../../../../data/models/me_model.dart';
import '../../../../data/repositories/auth/user_repository.dart';
import 'update_user_state.dart';
part 'update_user_event.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRepository userRepository;

  UpdateUserBloc({required this.userRepository})
      : super(UpdateUserState.initial()) {
    on<UpdateUserStarted>(_onUpdateUserStarted);
  }

  Future<void> _onUpdateUserStarted(
      UpdateUserStarted event,
      Emitter<UpdateUserState> emit,
      ) async {
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
          updatedUser: updatedUser,
        ));
      },
    );
  }
}