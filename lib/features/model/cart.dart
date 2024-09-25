class CartType {
  int id;
  String name;
  String category;
  String size;
  String price;
  String image;

  CartType({
    required this.id,
    required this.name,
    required this.category,
    required this.size,
    required this.price,
    required this.image,
  });
}

var cartList = [
  CartType(
    id: 1,
    name: "Raiden Shogoun Ba'al",
    image: "assets/costum2.png",
    category: 'Anime',
    size: 'M',
    price: '500.000',
  ),
  CartType(
    id: 2,
    image: 'assets/costum2.png',
    name: "Kobo Kanaeru",
    category: 'Anime',
    size: 'L',
    price: '700.000',
  ),
  CartType(
    id: 3,
    image: 'assets/costum3.png',
    name: "Kadita",
    category: 'Superhero',
    size: 'XL',
    price: '2.500.000',
  ),
  CartType(
    id: 4,
    image: 'assets/costum4.png',
    name: "Furina",
    category: 'Superhero',
    size: 'M',
    price: '1.200.000',
  ),
  CartType(
    id: 5,
    image: 'assets/costum5.png',
    name: "Kagura Water lily",
    category: 'Anime',
    size: 'L',
    price: '900.000',
  ),
  CartType(
    id: 6,
    image: 'assets/costum5.png',
    name: "Kagura Water lily",
    category: 'Anime',
    size: 'L',
    price: '900.000',
  ),
];
