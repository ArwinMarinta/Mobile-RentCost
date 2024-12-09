class CartResponse {
  final String message;
  final CartData data;

  CartResponse({
    required this.message,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      message: json['message'],
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final Address address;
  final List<CartItem> cartItem;

  CartData({
    required this.address,
    required this.cartItem,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      address: Address.fromJson(json['address']),
      cartItem: (json['cartItem'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}

class Address {
  final int id;
  final AddressDetails address;

  Address({
    required this.id,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      address: AddressDetails.fromJson(json['address']),
    );
  }
}

class AddressDetails {
  final int id;
  final String username;
  final String phoneNumber;
  final String city;
  final String state;
  final String zipCode;
  final String address1;
  final String address2;
  final String createdAt;
  final bool used;

  AddressDetails({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.address1,
    required this.address2,
    required this.createdAt,
    required this.used,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      address1: json['address1'],
      address2: json['address2'],
      createdAt: json['created_at'],
      used: json['used'],
    );
  }
}

class CartItem {
  final int id;
  final int quantity;
  final Cart cart;
  final Product product;
  final Size size;

  CartItem({
    required this.id,
    required this.quantity,
    required this.cart,
    required this.product,
    required this.size,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      cart: Cart.fromJson(json['cart']),
      product: Product.fromJson(json['product']),
      size: Size.fromJson(json['size']),
    );
  }
}

class Cart {
  final int id;

  Cart({
    required this.id,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
    );
  }
}

class Product {
  final int id;
  final String productName;
  final int rate;
  final int price;
  final String imageUrl;
  final int rentalAmount;
  final Category category;
  final List<Stock> stock;

  Product({
    required this.id,
    required this.productName,
    required this.rate,
    required this.price,
    required this.imageUrl,
    required this.rentalAmount,
    required this.category,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['product_name'],
      rate: json['rate'],
      price: json['price'],
      imageUrl: json['image_url'],
      rentalAmount: json['rental_amount'],
      category: Category.fromJson(json['category']),
      stock:
          (json['stock'] as List).map((item) => Stock.fromJson(item)).toList(),
    );
  }
}

class Category {
  final int id;
  final String categoryName;

  Category({
    required this.id,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['category_name'],
    );
  }
}

class Stock {
  final int id;
  final int stok;
  final bool available;

  Stock({
    required this.id,
    required this.stok,
    required this.available,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      stok: json['stok'],
      available: json['available'],
    );
  }
}

class Size {
  final int id;
  final String sizeName;

  Size({
    required this.id,
    required this.sizeName,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      sizeName: json['size_name'],
    );
  }
}
