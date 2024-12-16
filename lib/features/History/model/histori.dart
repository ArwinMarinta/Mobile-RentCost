class Product {
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

  Product({
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
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
    );
  }

  Product copyWith({
    int? id,
    String? productName,
    String? rate,
    int? price,
    String? imageUrl,
    int? rentalAmount,
    int? discount,
    bool? available,
    DateTime? createdAt,
    Category? category,
  }) {
    return Product(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      rate: rate ?? this.rate,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      rentalAmount: rentalAmount ?? this.rentalAmount,
      discount: discount ?? this.discount,
      available: available ?? this.available,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
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

  Category copyWith({
    int? id,
    String? categoryName,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return Category(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class HistoryItem {
  final int id;
  final String status;
  final bool rating;
  final int quantity;
  final DateTime createdAt;
  final Product product;

  HistoryItem({
    required this.id,
    required this.status,
    required this.rating,
    required this.quantity,
    required this.createdAt,
    required this.product,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      status: json['status'],
      rating: json['rating'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      product: Product.fromJson(json['product']),
    );
  }

  HistoryItem copyWith({
    int? id,
    String? status,
    bool? rating,
    int? quantity,
    DateTime? createdAt,
    Product? product,
  }) {
    return HistoryItem(
      id: id ?? this.id,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      product: product ?? this.product,
    );
  }
}

class HistoryResponse {
  final String message;
  final List<HistoryItem> data;

  HistoryResponse({
    required this.message,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<HistoryItem> historyList = list.isNotEmpty
        ? list.map((i) => HistoryItem.fromJson(i)).toList()
        : [];

    return HistoryResponse(
      message: json['message'],
      data: historyList,
    );
  }
}
