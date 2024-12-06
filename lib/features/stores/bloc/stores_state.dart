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
