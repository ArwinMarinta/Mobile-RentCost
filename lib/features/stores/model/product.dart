class ProductUserRent {
  int id;
  String productName;
  String rate;
  int price;
  String imageUrl;
  int rentalAmount;
  int discount;
  bool available;
  DateTime createdAt;

  ProductUserRent({
    required this.id,
    required this.productName,
    required this.rate,
    required this.price,
    required this.imageUrl,
    required this.rentalAmount,
    required this.discount,
    required this.available,
    required this.createdAt,
  });

  factory ProductUserRent.fromJson(Map<String, dynamic> json) {
    return ProductUserRent(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? 'Unknown',
      rate: json['rate'] ?? 0,
      price: json['price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      rentalAmount: json['rental_amount'] ?? 0,
      discount: json['discount'] ?? 0,
      available: json['available'] ?? false,
      createdAt:
          DateTime.parse(json['created_at'] ?? '1970-01-01T00:00:00.000Z'),
    );
  }
}
