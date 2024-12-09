class AddressData {
  final int id;
  final String username;
  final String phoneNumber;
  final String city;
  final String state;
  final String zipCode;
  final String address1;
  final String address2;
  final DateTime createdAt;
  final bool used;

  AddressData({
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

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      address1: json['address1'],
      address2: json['address2'],
      used: json['used'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
