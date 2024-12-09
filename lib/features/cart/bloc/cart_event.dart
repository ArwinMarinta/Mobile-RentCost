import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartToItemRequest extends CartEvent {
  final String id;
  final String sizeId;

  CartToItemRequest({required this.id, required this.sizeId});

  @override
  List<Object> get props => [id, sizeId];
}
