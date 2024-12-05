import 'package:equatable/equatable.dart';
import 'package:rentcost/features/category/model/category_model.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final String message;

  CategoriesSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CategoriesFailure extends CategoriesState {
  final String error;

  CategoriesFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CategoriesLoaded extends CategoriesState {
  final List<Categories> categories;

  CategoriesLoaded({required this.categories});
}

class CategoriesCreateFailure extends CategoriesState {
  final String error;

  CategoriesCreateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CategoriesCreateSuccess extends CategoriesState {
  final String message;

  CategoriesCreateSuccess({required this.message});
}

class CategoriesCreateLoading extends CategoriesState {}

class CategoriesDeleteLoading extends CategoriesState {}

class CategoriesDeleteSuccess extends CategoriesState {
  final String message;

  CategoriesDeleteSuccess({required this.message});
}

class CategoriesDeleteFailure extends CategoriesState {
  final String error;

  CategoriesDeleteFailure({required this.error});

  @override
  List<Object> get props => [error];
}
