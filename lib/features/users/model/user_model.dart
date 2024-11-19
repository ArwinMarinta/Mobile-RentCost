class User {
  String message;
  Data data;

  User({
    required this.message,
    required this.data,
  });

  // Tambahkan metode fromJson untuk parsing response
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

  Data({
    required this.id,
    required this.email,
    required this.password,
    required this.isVerified,
    required this.createdAt,
    required this.user,
  });

  // Tambahkan metode fromJson untuk parsing response
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      isVerified: json['is_verified'],
      createdAt: DateTime.parse(json['created_at']),
      user: UserClass.fromJson(json['user']),
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

  // Tambahkan metode fromJson untuk parsing response
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
