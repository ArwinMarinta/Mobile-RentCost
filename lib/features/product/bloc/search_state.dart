import 'package:equatable/equatable.dart';
import 'package:rentcost/features/category/model/category_model.dart';
import 'package:rentcost/features/product/model/product.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchNewsinitial extends SearchState {}

class SearchPopulersinitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final String message;

  SearchSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class SearchProductState extends SearchState {
  final List<ProductData> search;

  SearchProductState({required this.search});
}
