import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/address_model.dart';
import 'package:storeapp/data/repositories/address_repository.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_state.dart';

part 'address_event.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository _addressRepository;

  AddressBloc({required AddressRepository addressRepo})
      : _addressRepository = addressRepo,
        super(AddressState.initial()) {
    on<AddressLoading>(_onAddressLoading);
    on<AddressPost>(_onAddressPost);
    on<AddressDelete>(_onAddressDelete);

    add(AddressLoading());
  }

  // GET
  Future<void> _onAddressLoading(
      AddressLoading event,
      Emitter<AddressState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _addressRepository.getAddresses();

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
          address: value,
        ),
      ),
    );
  }
  Future<void> _onAddressPost(
      AddressPost event,
      Emitter<AddressState> emit,
      ) async {
    emit(state.copyWith(createStatus: Status.loading));

    final result = await _addressRepository.saveAddress(event.address);

    result.fold(
          (error) => emit(
        state.copyWith(
          createStatus: Status.error,
          errorMessage: error.toString(),
        ),
      ),
          (value) {
        final updatedList = List<AddressModel>.from(state.address);

        if (event.address.isDefault) {
          for (var i = 0; i < updatedList.length; i++) {
            updatedList[i] = updatedList[i].copyWith(isDefault: false);
          }
        }

        final index = updatedList.indexWhere((a) => a.id == value.id);
        if (index != -1) {
          updatedList[index] = value;
        } else {
          updatedList.add(value);
        }

        emit(
          state.copyWith(
            createStatus: Status.success,
            address: updatedList,
          ),
        );
      },
    );
  }
  Future<void> _onAddressDelete(
      AddressDelete event,
      Emitter<AddressState> emit,
      ) async {
    emit(state.copyWith(deleteStatus: Status.loading));

    final result = await _addressRepository.deleteAddress(event.id);

    result.fold(
          (error) => emit(
        state.copyWith(
          deleteStatus: Status.error,
          errorMessage: error.toString(),
        ),
      ),
          (_) {
        final updatedList =
        state.address.where((e) => e.id != event.id).toList();

        emit(
          state.copyWith(
            deleteStatus: Status.success,
            address: updatedList,
          ),
        );
      },
    );
  }
}
