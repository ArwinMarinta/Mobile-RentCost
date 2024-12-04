import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreCreate extends StoreEvent {
  final String store_name;
  final String store_location;

  StoreCreate({required this.store_name, required this.store_location});

  @override
  List<Object> get props => [store_name, store_location];
}
