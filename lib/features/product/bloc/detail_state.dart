import 'package:equatable/equatable.dart';
import 'package:rentcost/features/product/model/detail.dart';

abstract class DetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailInitial extends DetailState {}

class DetailNewsinitial extends DetailState {}

class DetailPopulersinitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {
  final String message;

  DetailSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class DetailFailure extends DetailState {
  final String error;

  DetailFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class DetailProductState extends DetailState {
  final ProductDetailModel detail;

  DetailProductState({required this.detail});
}
