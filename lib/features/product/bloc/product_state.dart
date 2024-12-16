import 'package:equatable/equatable.dart';
import 'package:rentcost/features/product/model/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductNewsinitial extends ProductState {}

class ProductPopulersinitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final String message;

  ProductSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductFailure extends ProductState {
  final String error;

  ProductFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class ProductPopulerState extends ProductState {
  final List<ProductData> populer;

  ProductPopulerState({required this.populer});
}

final class ProductNewsState extends ProductState {
  final List<ProductData> news;

  ProductNewsState({required this.news});
}

final class ProductFilters extends ProductState {
  final List<ProductData> populer;
  final List<ProductData> news;

  ProductFilters({required this.news, required this.populer});
}

final class ProductSearchState extends ProductState {
  final List<ProductData> search;

  ProductSearchState({required this.search});
}

final class ProductDeleteLoading extends ProductState {}

final class ProductDeleteSuccess extends ProductState {
  final String message;

  ProductDeleteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProductDeleteFailure extends ProductState {
  final String error;

  ProductDeleteFailure({required this.error});

  @override
  List<Object> get props => [error];
}
