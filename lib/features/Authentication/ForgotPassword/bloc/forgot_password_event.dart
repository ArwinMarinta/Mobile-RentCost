import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgotPasswordRequest extends ForgotPasswordEvent {
  final String token;
  final String password;
  final String confirm_password;

  ForgotPasswordRequest({
    required this.token,
    required this.password,
    required this.confirm_password,
  });

  @override
  List<Object> get props => [token, password, confirm_password];
}
