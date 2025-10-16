part of 'address_bloc.dart';

abstract class AddressEvent {}

class AddressLoading extends AddressEvent {}

class AddressPost extends AddressEvent {
  final AddressModel address;
  AddressPost(this.address);
}

class AddressDelete extends AddressEvent {
  final int id;
  AddressDelete(this.id);
}
