import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesRequest extends CategoriesEvent {
  CategoriesRequest();

  @override
  List<Object> get props => [];
}
