class Categories {
  final int id;
  final String category_name;
  final String image_url;

  Categories({
    required this.id,
    required this.category_name,
    required this.image_url,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      category_name: json['category_name'],
      image_url: json['image_url'],
    );
  }
}
