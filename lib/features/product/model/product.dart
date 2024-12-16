class ProductData {
  final int id;
  final String productName;
  final String rate;
  final int price;
  final String imageUrl;
  final int rentalAmount;
  final int discount;
  final bool available;
  final DateTime createdAt;
  final Category category;
  final Store store;

  ProductData({
    required this.id,
    required this.productName,
    required this.rate,
    required this.price,
    required this.imageUrl,
    required this.rentalAmount,
    required this.discount,
    required this.available,
    required this.createdAt,
    required this.category,
    required this.store,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      productName: json['product_name'],
      rate: json['rate'],
      price: json['price'],
      imageUrl: json['image_url'],
      rentalAmount: json['rental_amount'],
      discount: json['discount'],
      available: json['available'],
      createdAt: DateTime.parse(json['created_at']),
      category: Category.fromJson(json['category']),
      store: Store.fromJson(json['store']),
    );
  }
}

class Category {
  final int id;
  final String categoryName;
  final String imageUrl;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.categoryName,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['category_name'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Store {
  final int id;
  final String storeName;
  final String storeLocation;
  final DateTime createdAt;

  Store({
    required this.id,
    required this.storeName,
    required this.storeLocation,
    required this.createdAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      storeName: json['store_name'],
      storeLocation: json['store_location'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
