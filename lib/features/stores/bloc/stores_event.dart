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
  final String productName;
  final String price;
  final String imageUrl;
  final String categoryId;
  final List<Map<String, dynamic>> sizeStock;

  ProductCreateEvent({
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.sizeStock,
  });

  @override
  List<Object> get props =>
      [productName, price, imageUrl, categoryId, sizeStock];
}

class StockDelete extends StoreEvent {
  final String id;

  StockDelete({required this.id});

  @override
  List<Object> get props => [id];
}

class StockCreate extends StoreEvent {
  final String id;
  final String sizeId;
  final String stok;

  StockCreate({required this.id, required this.sizeId, required this.stok});

  @override
  List<Object> get props => [id, sizeId, stok];
}

class ProductUpdateEvent extends StoreEvent {
  final String productName;
  final String price;
  final String imageUrl;
  final String categoryId;
  final String id;
  final String oldImageUrl;

  ProductUpdateEvent({
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.id,
    required this.oldImageUrl,
  });

  @override
  List<Object> get props =>
      [productName, price, imageUrl, categoryId, id, oldImageUrl];
}

class StockUpdate extends StoreEvent {
  final String id;
  final String sizeId;
  final String stok;

  StockUpdate({required this.id, required this.sizeId, required this.stok});

  @override
  List<Object> get props => [id, sizeId, stok];
}
