import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterRequest extends RegisterEvent {
  final String username;
  final String email;
  final String phone_number;
  final String password;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.phone_number,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, phone_number, password];
}
