import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/address_model.dart';

part 'address_state.freezed.dart';

@freezed
abstract class AddressState with _$AddressState {
  const factory AddressState({
    required Status status,
    required Status createStatus,
    required Status deleteStatus,
    String? errorMessage,
    required List<AddressModel> address,
  }) = _AddressState;

  factory AddressState.initial() => AddressState(
    status: Status.initial,
    createStatus: Status.initial,
    deleteStatus: Status.initial,
    errorMessage: null,
    address: [],
  );
}
