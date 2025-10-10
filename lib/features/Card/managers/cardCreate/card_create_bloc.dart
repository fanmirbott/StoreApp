import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/card/card_create_repository.dart';
import 'card_create_event.dart';
import 'card_create_state.dart';

class CardCreateBloc extends Bloc<CardCreateEvent, CardCreateState> {
  final CardCreateRepository repository;

  CardCreateBloc({required this.repository})
      : super(const CardCreateState.initial()) {
    on<CardCreateEvent>((event, emit) async {
      await event.map(
        create: (e) async {
          emit(const CardCreateState.loading());
          final result = await repository.postCard(
            cardNumber: e.cardNumber,
            expiryDate: e.expiryDate,
            securityCode: e.securityCode,
          );
          result.fold(
                (err) => emit(CardCreateState.failure(err.toString())),
                (data) => emit(CardCreateState.success(data)),
          );
        },
      );
    });
  }
}
