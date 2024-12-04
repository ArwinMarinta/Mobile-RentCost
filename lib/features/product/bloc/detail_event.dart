import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailProduct extends DetailEvent {
  final String id;

  DetailProduct({required this.id});
}
