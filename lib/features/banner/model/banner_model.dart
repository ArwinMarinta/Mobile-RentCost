class BannerResponse {
  final int id;
  final String bannerName;
  final String imageUrl;

  BannerResponse({
    required this.id,
    required this.bannerName,
    required this.imageUrl,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      id: json['id'],
      bannerName: json['banner_name'],
      imageUrl: json['image_url'],
    );
  }
}
