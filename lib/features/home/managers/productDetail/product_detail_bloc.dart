import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/features/home/managers/productDetail/product_detail_state.dart';

import '../../../../core/utils/status.dart';
import '../../../../data/repositories/products/product_detail_repository.dart';

part 'product_detail_event.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepository _detailRepository;

  ProductDetailBloc({
    required ProductDetailRepository detailRepository,
  })  : _detailRepository = detailRepository,
        super(ProductDetailState.initial()) {
    on<ProductDetailLoading>(_onProductDetailLoading);
  }

  Future<void> _onProductDetailLoading(
      ProductDetailLoading event,
      Emitter<ProductDetailState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _detailRepository.getProductDetail(event.id);

    result.fold(
          (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      },
          (value) {
        emit(
          state.copyWith(
            status: Status.success,
            productDetails: value,
          ),
        );
      },
    );
  }
}
