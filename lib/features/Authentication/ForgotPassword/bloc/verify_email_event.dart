import 'package:equatable/equatable.dart';

abstract class VerifyEmailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyEmailRequest extends VerifyEmailEvent {
  final String email;

  VerifyEmailRequest({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class RessetToken extends VerifyEmailEvent {
  RessetToken();

  @override
  List<Object> get props => [];
}
