import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import '../../../../data/repositories/card_repository.dart';
import 'card_state.dart';

part 'card_event.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository _cardRepo;

  CardBloc({required CardRepository cardRepo})
      : _cardRepo = cardRepo,
        super(CardState.initial()) {
    on<CardLoading>(_onCardLoading);
    on<CardCreate>(_onCardCreate);
    on<CardDelete>(_onCardDelete);

    add(CardLoading());
  }

  Future<void> _onCardLoading(
      CardLoading event,
      Emitter<CardState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));

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

  Future<void> _onCardCreate(
      CardCreate event,
      Emitter<CardState> emit,
      ) async {
    emit(state.copyWith(createStatus: Status.loading, errorMessage: null));

    final result = await _cardRepo.postCard(
      cardNumber: event.cardNumber,
      expiryDate: event.expiryDate,
      securityCode: event.securityCode,
    );

    await result.fold(
          (err) async {
        emit(state.copyWith(
          createStatus: Status.error,
          errorMessage: err.toString(),
        ));
      },
          (data) async {
        emit(state.copyWith(createStatus: Status.success));

        await _onCardLoading(CardLoading(), emit);

        emit(state.copyWith(createStatus: Status.success));
      },
    );
  }

  Future<void> _onCardDelete(
      CardDelete event,
      Emitter<CardState> emit,
      ) async {
    emit(state.copyWith(deleteStatus: Status.loading, errorMessage: null));

    final result = await _cardRepo.deleteCard(event.cardId);

    await result.fold(
          (error) async {
        emit(state.copyWith(
          deleteStatus: Status.error,
          errorMessage: error.toString(),
        ));
      },
          (_) async {
        emit(state.copyWith(deleteStatus: Status.success));

        await _onCardLoading(CardLoading(), emit);

        emit(state.copyWith(deleteStatus: Status.success));
      },
    );
  }
}