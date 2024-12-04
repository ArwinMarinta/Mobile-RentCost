class ProductDetailModel {
  String message;
  ProductData data;

  ProductDetailModel({required this.message, required this.data});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    // Pastikan ada key 'data' dan 'stock' sebelum diproses
    if (json['data'] == null) {
      throw Exception('Data tidak ditemukan dalam response');
    }

    // Ambil daftar 'stock' dan pastikan jika null, default ke list kosong
    var stockList = json['data']['stock'] as List? ?? [];

    // Memetakan setiap item di stock menjadi objek Stock
    List<Stock> stockItems = stockList.map((i) => Stock.fromJson(i)).toList();

    // Kembalikan model ProductDetailModel
    return ProductDetailModel(
      message: json['message'] ??
          'No message', // Default ke 'No message' jika tidak ada
      data: ProductData.fromJson(json['data'], stockItems),
    );
  }
}

class ProductData {
  int id;
  String productName;
  int rate;
  int price;
  String imageUrl;
  int rentalAmount;
  List<Stock> stock;
  Store store;

  ProductData({
    required this.id,
    required this.productName,
    required this.rate,
    required this.price,
    required this.imageUrl,
    required this.rentalAmount,
    required this.stock,
    required this.store,
  });

  factory ProductData.fromJson(
      Map<String, dynamic> json, List<Stock> stockItems) {
    return ProductData(
      id: json['id'] ?? 0, // Jika id tidak ditemukan
      productName:
          json['product_name'] ?? 'Unknown', // Jika product_name tidak ada
      rate: json['rate'] ?? 0,
      price: json['price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      rentalAmount: json['rental_amount'] ?? 0,
      stock: stockItems,
      store: Store.fromJson(json['store'] ?? {}),
    );
  }
}

class Stock {
  int id;
  int stok;
  bool available;
  Size size; // Menambahkan properti untuk size

  Stock(
      {required this.id,
      required this.stok,
      required this.available,
      required this.size});

  factory Stock.fromJson(Map<String, dynamic> json) {
    // Membaca data size dan mengonversinya menjadi objek Size
    var sizeData = json['size'] != null
        ? Size.fromJson(json['size'])
        : Size(sizeName: 'Unknown');

    return Stock(
      id: json['id'] ?? 0,
      stok: json['stok'] ?? 0,
      available: json['available'] ?? false,
      size: sizeData, // Assign data size
    );
  }
}

class Size {
  String sizeName;

  Size({required this.sizeName});

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      sizeName:
          json['size_name'] ?? 'Unknown', // Default ke 'Unknown' jika tidak ada
    );
  }
}

class Store {
  int id;
  String storeName;
  String storeLocation;

  Store({
    required this.id,
    required this.storeName,
    required this.storeLocation,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? 0,
      storeName: json['store_name'] ?? 'Unknown',
      storeLocation: json['store_location'] ?? 'Unknown',
    );
  }
}
