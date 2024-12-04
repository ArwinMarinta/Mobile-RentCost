class ProductData {
  final int id;
  final String productName;
  final int rate;
  final int price;
  final String imageUrl;
  final int rentalAmount;
  final int discount;
  final bool available;
  final DateTime createdAt;

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
    );
  }
}
