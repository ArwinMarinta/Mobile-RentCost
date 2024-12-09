import 'package:equatable/equatable.dart';
import 'package:rentcost/features/category/model/category_model.dart';

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

// class CartLoaded extends CartState {
//   final List<Cart> Cart;

//   CartLoaded({required this.Cart});
// }

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
