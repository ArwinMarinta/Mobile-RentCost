class User {
  String message;
  Data data;

  User({
    required this.message,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int id;
  String email;
  String password;
  bool isVerified;
  DateTime createdAt;
  UserClass user;
  Store? store;

  Data({
    required this.id,
    required this.email,
    required this.password,
    required this.isVerified,
    required this.createdAt,
    required this.user,
    this.store, // Parameter store bisa null
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['auth']['id'],
      email: json['auth']['email'],
      password: json['auth']['password'],
      isVerified: json['auth']['is_verified'],
      createdAt: DateTime.parse(json['auth']['created_at']),
      user: UserClass.fromJson(json['auth']['user']),
      store: json['store'] != null
          ? Store.fromJson(json['store'])
          : null, // Cek apakah store ada
    );
  }
}

class UserClass {
  int id;
  String username;
  String phoneNumber;
  String location;
  String identifyType;
  String identityNumber;
  String bankAccount;
  String imageUrl;
  DateTime createdAt;

  UserClass({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.location,
    required this.identifyType,
    required this.identityNumber,
    required this.bankAccount,
    required this.imageUrl,
    required this.createdAt,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      location: json['location'],
      identifyType: json['identify_type'],
      identityNumber: json['identity_number'],
      bankAccount: json['bank_account'],
      imageUrl: json['image_url'], // Mengakses imageUrl
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

// Model Store
class Store {
  int id;
  String storeName;
  String storeLocation;
  DateTime createdAt;

  Store({
    required this.id,
    required this.storeName,
    required this.storeLocation,
    required this.createdAt,
  });

  // Tambahkan metode fromJson untuk parsing response
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      storeName: json['store_name'],
      storeLocation: json['store_location'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
