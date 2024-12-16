import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccessEvent extends PaymentState {
  final String message;

  PaymentSuccessEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class PaymentFailure extends PaymentState {
  final String error;

  PaymentFailure({required this.error});

  @override
  List<Object> get props => [error];
}
