import 'package:equatable/equatable.dart';
import 'package:rentcost/features/address/model/address_model.dart';

abstract class AddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressSuccess extends AddressState {
  final String message;

  AddressSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddressFailure extends AddressState {
  final String error;

  AddressFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class AddressLoaded extends AddressState {
  final List<AddressData> address;

  AddressLoaded({required this.address});

  @override
  List<Object?> get props => [address];
}

class AddressCreateLoading extends AddressState {}

class AddressCreateSuccess extends AddressState {
  final String message;

  AddressCreateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddressCreateFailure extends AddressState {
  final String error;

  AddressCreateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class AddressDeleteLoading extends AddressState {}

class AddressDeleteSuccess extends AddressState {
  final String message;

  AddressDeleteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddressDeleteFailure extends AddressState {
  final String error;

  AddressDeleteFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class AddressUpdateLoading extends AddressState {}

class AddressUpdateSuccess extends AddressState {
  final String message;

  AddressUpdateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddressUpdateFailure extends AddressState {
  final String error;

  AddressUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}
