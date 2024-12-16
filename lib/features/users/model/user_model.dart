class UserResponse {
  final String message;
  final Data data;

  UserResponse({required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final Auth auth;
  final dynamic
      store; // Store bisa null atau memiliki value, jadi kita gunakan dynamic

  Data({required this.auth, this.store});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      auth: Auth.fromJson(json['auth']),
      store: json['store'], // Bisa null
    );
  }
}

class Auth {
  final int id;
  final String email;
  final String password;
  final bool isVerified;
  final String createdAt;
  final User user;

  Auth({
    required this.id,
    required this.email,
    required this.password,
    required this.isVerified,
    required this.createdAt,
    required this.user,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      isVerified: json['is_verified'],
      createdAt: json['created_at'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String username;
  final String phoneNumber;
  final dynamic location; // Bisa null
  final dynamic identifyType; // Bisa null
  final dynamic identityNumber; // Bisa null
  final dynamic bankAccount; // Bisa null
  final String? imageUrl; // Bisa null
  final String createdAt;

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    this.location,
    this.identifyType,
    this.identityNumber,
    this.bankAccount,
    this.imageUrl,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      location: json['location'],
      identifyType: json['identify_type'],
      identityNumber: json['identity_number'],
      bankAccount: json['bank_account'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
    );
  }
}
