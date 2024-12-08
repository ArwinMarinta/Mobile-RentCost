import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreSuccess extends StoreState {
  final String message;

  StoreSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class StoreFailure extends StoreState {
  final String error;

  StoreFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ProductLoadingStore extends StoreState {}

class ProductSuccessStore extends StoreState {
  final String message;

  ProductSuccessStore({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductFailureStore extends StoreState {
  final String error;

  ProductFailureStore({required this.error});

  @override
  List<Object> get props => [error];
}

class StockDeleteLoading extends StoreState {}

class StockDeleteSuccess extends StoreState {
  final String message;

  StockDeleteSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class StockDeleteFailure extends StoreState {
  final String error;

  StockDeleteFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class StockUpdateLoading extends StoreState {}

class StockUpdateSuccess extends StoreState {
  final String message;

  StockUpdateSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class StockUpdateFailure extends StoreState {
  final String error;

  StockUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class ProductUpdateLoading extends StoreState {}

final class ProductUpdateSuccess extends StoreState {
  final String message;

  ProductUpdateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProductUpdateFailure extends StoreState {
  final String error;

  ProductUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class StockCreateLoading extends StoreState {}

final class StockCreateSuccess extends StoreState {
  final String message;

  StockCreateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class StockCreateFailure extends StoreState {
  final String error;

  StockCreateFailure({required this.error});

  @override
  List<Object> get props => [error];
}
