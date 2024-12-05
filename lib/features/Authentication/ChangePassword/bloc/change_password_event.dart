import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordRequest extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confPassword;

  ChangePasswordRequest(
      {required this.oldPassword,
      required this.newPassword,
      required this.confPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}
