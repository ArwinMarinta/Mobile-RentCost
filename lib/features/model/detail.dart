class Detail {
  String image;
  String name;
  String rating;
  String tersewa;
  String category;
  String price;

  Detail(
      {required this.image,
      required this.name,
      required this.rating,
      required this.tersewa,
      required this.category,
      required this.price});
}

var detail = Detail(
  image: "assets/costum1.png",
  name: "Product 1",
  rating: "4.5",
  tersewa: "10",
  category: "Clothing",
  price: "\$20.00",
);
