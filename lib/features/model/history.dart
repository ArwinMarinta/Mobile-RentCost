class History {
  String status;
  String order_number;
  String quantity;
  String image;
  String category;
  String name;
  String size;

  History({
    required this.status,
    required this.order_number,
    required this.quantity,
    required this.category,
    required this.image,
    required this.name,
    required this.size,
  });
}

var hustoryList = [
  History(
      status: "Pembayaran Gagal",
      order_number: "7382633",
      quantity: '2',
      category: "genshin impact",
      image: 'assets/costum1.png',
      name: "Raiden Shogoun Ba'al",
      size: "L"),
  History(
      status: "Dalam Pengiriman",
      order_number: "7382633",
      quantity: '2',
      category: "genshin impact",
      image: 'assets/costum1.png',
      name: "Raiden Shogoun Ba'al",
      size: "L"),
  History(
      status: "Pesanan Diterima",
      order_number: "7382633",
      quantity: '2',
      category: "genshin impact",
      image: 'assets/costum1.png',
      name: "Raiden Shogoun Ba'al",
      size: "L"),
];
