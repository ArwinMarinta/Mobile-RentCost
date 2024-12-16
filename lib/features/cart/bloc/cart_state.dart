import 'package:equatable/equatable.dart';
import 'package:rentcost/features/cart/model/cart.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final String message;

  CartSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartFailure extends CartState {
  final String error;

  CartFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CartLoaded extends CartState {
  final CartResponse cart;

  CartLoaded({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];
}

class CartToItemLoading extends CartState {}

class CartToItemFailure extends CartState {
  final String error;

  CartToItemFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CartToItemSuccess extends CartState {
  final String message;

  CartToItemSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class CartDeleteLoading extends CartState {}

class CartDeleteSuccess extends CartState {
  final String message;

  CartDeleteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartDeleteFailure extends CartState {
  final String error;

  CartDeleteFailure({required this.error});

  @override
  List<Object> get props => [error];
}
