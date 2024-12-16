import 'package:equatable/equatable.dart';

abstract class ProductUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProductClear extends ProductUserEvent {}

class ProductUser extends ProductUserEvent {
  ProductUser();

  @override
  List<Object> get props => [];
}
