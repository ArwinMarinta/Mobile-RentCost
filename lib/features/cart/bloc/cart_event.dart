import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartClear extends CartEvent {}

class CartToItemRequest extends CartEvent {
  final String id;
  final String sizeId;

  CartToItemRequest({required this.id, required this.sizeId});

  @override
  List<Object> get props => [id, sizeId];
}

class CartRequest extends CartEvent {
  CartRequest();

  @override
  List<Object> get props => [];
}

class CartDeleteItem extends CartEvent {
  final String id;

  CartDeleteItem({required this.id});

  @override
  List<Object> get props => [id];
}
