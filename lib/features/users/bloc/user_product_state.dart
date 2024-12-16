import 'package:equatable/equatable.dart';
import 'package:rentcost/features/stores/model/product.dart';

abstract class ProductUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductUserInitial extends ProductUserState {}

class ProductUserLoading extends ProductUserState {}

class ProductUserSuccess extends ProductUserState {
  final String message;

  ProductUserSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductUserFailure extends ProductUserState {
  final String error;

  ProductUserFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class ProductUserLoaded extends ProductUserState {
  final List<ProductUserRent> product;

  ProductUserLoaded({required this.product});

  @override
  List<Object> get props => [product];
}
