import 'package:equatable/equatable.dart';

abstract class VerifyEmailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {
  final String message;
  final String token;

  VerifyEmailSuccess({required this.message, required this.token});

  @override
  List<Object?> get props => [message, token];
}

class VerifyEmailFailure extends VerifyEmailState {
  final String error;

  VerifyEmailFailure({required this.error});

  @override
  List<Object> get props => [error];
}
