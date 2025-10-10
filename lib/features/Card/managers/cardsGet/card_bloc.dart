import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import '../../../../data/repositories/card/card_list_repository.dart';
import 'card_state.dart';
part 'card_event.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardListRepository _cardRepo;

  CardBloc({required CardListRepository cardRepo})
      : _cardRepo = cardRepo,
        super(CardState.initial()) {
    on<CardLoading>(_onCardLoading);
    add(CardLoading());
  }

  Future<void> _onCardLoading(
      CardLoading event,
      Emitter<CardState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _cardRepo.getCards();

    result.fold(
          (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
          (cards) => emit(
        state.copyWith(status: Status.success, cards: cards),
      ),
    );
  }
}
