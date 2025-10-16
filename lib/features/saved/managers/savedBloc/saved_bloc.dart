import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/saved/managers/savedBloc/saved_state.dart';
import '../../../../data/repositories/product_repository.dart';
part 'saved_event.dart';

class SavedProductsBloc extends Bloc<SavedProductsEvent, SavedProductsState> {
  final ProductRepository _repository;

  SavedProductsBloc({required ProductRepository repository})
      : _repository = repository,
        super(SavedProductsState.initial()) {

    on<FetchSavedProducts>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final result = await _repository.getSavedProducts();
      result.fold(
            (error) => emit(state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
          savedProducts: [],
        )),
            (value) => emit(state.copyWith(
          status: Status.success,
          savedProducts: value,
        )),
      );
    });

    on<SaveProductEvent>((event, emit) {
      // serverga saqlash so‘rovi qo‘shilishi mumkin
      // UI faqat BLoC orqali yangilanishi
      final updatedList = List.of(state.savedProducts);
      // agar hali mavjud bo‘lmasa qo‘shish
      if (!updatedList.any((p) => p.id == event.productId)) {
        // server so‘rovi
        emit(state.copyWith(savedProducts: updatedList));
      }
    });

    on<UnSaveProductEvent>((event, emit) {
      final updatedList = List.of(state.savedProducts)
        ..removeWhere((p) => p.id == event.productId);
      emit(state.copyWith(savedProducts: updatedList));
      // serverga o‘chirish so‘rovi shu yerda bo‘lishi mumkin
    });
  }
}
