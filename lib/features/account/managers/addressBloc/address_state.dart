import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/models/address_model.dart';

part 'address_state.freezed.dart';

@freezed
abstract class AddressState with _$AddressState {
  const factory AddressState({
    required Status status,
    String? errorMessage,
    required List<AddressModel> address,
  }) = _AddressState;

  factory AddressState.initial() => AddressState(
    status: Status.loading,
    errorMessage: null,
    address: [],
  );
}
