import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/product_model.dart';
import 'package:storeapp/data/repositories/saved_repository.dart';
import 'saved_state.dart';
part 'saved_event.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final SavedRepository _repository;

  SavedBloc({required SavedRepository repository})
      : _repository = repository,
        super(SavedState.initial()) {
    on<SaveProductEvent>(_onSaveProduct);
    on<UnSaveProductEvent>(_onUnSaveProduct);
  }

  Future<void> _onSaveProduct(
      SaveProductEvent event,
      Emitter<SavedState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));

    final result = await _repository.saveProduct(event.product.id);

    result.fold(
          (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
          (_) {
        event.product.isLiked = true;
        emit(state.copyWith(status: Status.success));
      },
    );
  }

  Future<void> _onUnSaveProduct(
      UnSaveProductEvent event,
      Emitter<SavedState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));

    final result = await _repository.unSaveProduct(event.product.id);

    result.fold(
          (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
          (_) {
        event.product.isLiked = false;
        emit(state.copyWith(status: Status.success));
      },
    );
  }
}
