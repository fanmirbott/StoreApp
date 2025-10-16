import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/repositories/product_repository.dart';
import 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required ProductRepository productRepo,
  })  : _productRepo = productRepo,
        super(ProductState.initial()) {
    on<ProductLoading>(_onProductLoading);
    on<UpdateProductLike>(_onUpdateProductLike);
  }

  final ProductRepository _productRepo;

  Future<void> _onProductLoading(
      ProductLoading event,
      Emitter<ProductState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _productRepo.getProducts(
      categoryId: event.categoryId,
      title: event.title,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
      orderBy: event.orderBy,
      sizeId: event.sizeId,
    );

    result.fold(
          (error) => emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
          products: [],
        ),
      ),
          (value) => emit(
        state.copyWith(
          status: Status.success,
          products: value,
        ),
      ),
    );
  }

  void _onUpdateProductLike(
      UpdateProductLike event,
      Emitter<ProductState> emit,
      ) {
    final updatedList = List.of(state.products);
    final index = updatedList.indexWhere((p) => p.id == event.productId);

    if (index != -1) {
      updatedList[index].isLiked = event.isLiked;
      emit(state.copyWith(products: updatedList));
    }
  }
}
