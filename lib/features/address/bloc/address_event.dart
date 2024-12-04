import 'package:equatable/equatable.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddressRequest extends AddressEvent {
  AddressRequest();

  @override
  List<Object> get props => [];
}

class CreateAddress extends AddressEvent {
  final String username;
  final String phone_number;
  final String city;
  final String zip_code;
  final String state;
  final String address1;
  final String address2;

  CreateAddress(
      {required this.username,
      required this.phone_number,
      required this.city,
      required this.zip_code,
      required this.state,
      required this.address1,
      required this.address2});

  @override
  List<Object> get props =>
      [username, phone_number, city, zip_code, state, address1, address2];
}

class RequestAddress extends AddressEvent {
  RequestAddress();

  @override
  List<Object> get props => [];
}
