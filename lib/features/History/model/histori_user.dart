class ProductUser {
  final int id;
  final String productName;
  final String rate;
  final int price;
  final String imageUrl;
  final int rentalAmount;
  final int discount;
  final bool available;
  final DateTime createdAt;
  final CategoryUser category;

  ProductUser({
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

  factory ProductUser.fromJson(Map<String, dynamic> json) {
    return ProductUser(
      id: json['id'],
      productName: json['product_name'],
      rate: json['rate'],
      price: json['price'],
      imageUrl: json['image_url'],
      rentalAmount: json['rental_amount'],
      discount: json['discount'],
      available: json['available'],
      createdAt: DateTime.parse(json['created_at']),
      category: CategoryUser.fromJson(json['category']),
    );
  }

  ProductUser copyWith({
    int? id,
    String? productName,
    String? rate,
    int? price,
    String? imageUrl,
    int? rentalAmount,
    int? discount,
    bool? available,
    DateTime? createdAt,
    CategoryUser? category,
  }) {
    return ProductUser(
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

class CategoryUser {
  final int id;
  final String categoryName;
  final String imageUrl;
  final DateTime createdAt;

  CategoryUser({
    required this.id,
    required this.categoryName,
    required this.imageUrl,
    required this.createdAt,
  });

  factory CategoryUser.fromJson(Map<String, dynamic> json) {
    return CategoryUser(
      id: json['id'],
      categoryName: json['category_name'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  CategoryUser copyWith({
    int? id,
    String? categoryName,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return CategoryUser(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class HistoryItemUser {
  final int id;
  final String status;
  final bool rating;
  final int quantity;
  final DateTime createdAt;
  final ProductUser product;
  final SizeUSer size; // Added size

  HistoryItemUser({
    required this.id,
    required this.status,
    required this.rating,
    required this.quantity,
    required this.createdAt,
    required this.product,
    required this.size, // Added size
  });

  factory HistoryItemUser.fromJson(Map<String, dynamic> json) {
    return HistoryItemUser(
      id: json['id'],
      status: json['status'],
      rating: json['rating'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      product: ProductUser.fromJson(json['product']),
      size: SizeUSer.fromJson(json['size']), // Parsing size
    );
  }

  HistoryItemUser copyWith({
    int? id,
    String? status,
    bool? rating,
    int? quantity,
    DateTime? createdAt,
    ProductUser? product,
    SizeUSer? size, // Added size
  }) {
    return HistoryItemUser(
      id: id ?? this.id,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      product: product ?? this.product,
      size: size ?? this.size, // Added size
    );
  }
}

class SizeUSer {
  final int id;
  final String sizeName;
  final DateTime createdAt;

  SizeUSer({
    required this.id,
    required this.sizeName,
    required this.createdAt,
  });

  factory SizeUSer.fromJson(Map<String, dynamic> json) {
    return SizeUSer(
      id: json['id'],
      sizeName: json['size_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  SizeUSer copyWith({
    int? id,
    String? sizeName,
    DateTime? createdAt,
  }) {
    return SizeUSer(
      id: id ?? this.id,
      sizeName: sizeName ?? this.sizeName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class HistoryResponseUser {
  final String message;
  final List<HistoryItemUser> data;

  HistoryResponseUser({
    required this.message,
    required this.data,
  });

  factory HistoryResponseUser.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<HistoryItemUser> historyList = list.isNotEmpty
        ? list.map((i) => HistoryItemUser.fromJson(i)).toList()
        : [];

    return HistoryResponseUser(
      message: json['message'],
      data: historyList,
    );
  }
}
