import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/saved/savedProduct/saved_state.dart';
import '../../../../data/repositories/products/product_repository.dart';
part 'saved_event.dart';

class SavedProductsBloc extends Bloc<SavedProductsEvent, SavedProductsState> {
  SavedProductsBloc({
    required ProductRepository savedRepo,
  })  : _savedRepo = savedRepo,
        super(SavedProductsState.initial()) {
    on<FetchSavedProducts>(_onFetchSavedProducts);

    add(FetchSavedProducts());
  }

  final ProductRepository _savedRepo;

  Future<void> _onFetchSavedProducts(
      FetchSavedProducts event,
      Emitter<SavedProductsState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _savedRepo.getSavedProducts();

    result.fold(
          (error) => emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      ),
          (value) => emit(
        state.copyWith(
          status: Status.success,
          savedProducts: value,
        ),
      ),
    );
  }
}
