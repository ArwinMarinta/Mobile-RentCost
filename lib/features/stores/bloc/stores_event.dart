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

class ProductCreateEvent extends StoreEvent {
  final String product_name;
  final String price;
  final String image_url;
  final int category_id;
  final List<Map<String, dynamic>> size_stock;

  ProductCreateEvent({
    required this.product_name,
    required this.price,
    required this.image_url,
    required this.category_id,
    required this.size_stock,
  });

  @override
  List<Object> get props =>
      [product_name, price, image_url, category_id, size_stock];
}
