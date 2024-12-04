import 'package:equatable/equatable.dart';
import 'package:rentcost/features/address/model/address_model.dart';
import 'package:rentcost/features/category/model/category_model.dart';

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
}
