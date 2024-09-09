class Costum {
  String name;
  String price;
  String city;
  String rating;
  String tersewa;
  String path;

  Costum(
      {required this.name,
      required this.price,
      required this.city,
      required this.rating,
      required this.tersewa,
      required this.path});
}

var costumList = [
  Costum(
      path: "assets/costum1.png",
      name: "Raiden Shogoun Ba'al",
      price: "100.000",
      city: "Balikpapan",
      rating: "4.6",
      tersewa: "10 Tersewa"),
  Costum(
      path: 'assets/costum2.png',
      name: "Kobo Kanaeru",
      price: "100.000",
      city: "Balikpapan",
      rating: "4.6",
      tersewa: "10 Tersewa"),
  Costum(
      path: 'assets/costum3.png',
      name: "Kadita",
      price: "100.000",
      city: "Balikpapan",
      rating: "4.6",
      tersewa: "10 Tersewa"),
  Costum(
      path: 'assets/costum4.png',
      name: "Furina",
      price: "100.000",
      city: "Balikpapan",
      rating: "4.6",
      tersewa: "10 Tersewa"),
  Costum(
      path: 'assets/costum5.png',
      name: "Kagura Water lily",
      price: "100.000",
      city: "Balikpapan",
      rating: "4.6",
      tersewa: "10 Tersewa")
];
