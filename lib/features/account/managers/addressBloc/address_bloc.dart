import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/repositories/address_repository.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_state.dart';

part 'address_event.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc(this._addressRepository, {required AddressRepository addressRepo})
    : super(AddressState.initial()) {
    on<AddressLoading>(_onAddressLoading);
    add(AddressLoading());
  }

  final AddressRepository _addressRepository;

  Future<void> _onAddressLoading(
    AddressLoading event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _addressRepository.getAddresses();
    result.fold(
      (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
      (value) => emit(state.copyWith(status: Status.success, address: value)),
    );
  }
}
