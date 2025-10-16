import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/repositories/categories_repository.dart';
import 'categories_state.dart';
part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({
    required ICategories categoriesRepo,
  })  : _categoriesRepo = categoriesRepo,
        super(CategoriesState.initial()) {
    on<CategoriesLoading>(_onCategoriesLoading);
    add(CategoriesLoading());
  }

  final ICategories _categoriesRepo;

  Future<void> _onCategoriesLoading(
      CategoriesLoading event,
      Emitter<CategoriesState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _categoriesRepo.getCategories();

    result.fold(
          (error) => emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
          categories: [],
        ),
      ),
          (data) => emit(
        state.copyWith(
          status: Status.success,
          categories: data,
        ),
      ),
    );
  }
}
