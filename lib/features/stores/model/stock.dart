class StockItem {
  final int id;
  final int stok;
  final bool available;

  StockItem({
    required this.id,
    required this.stok,
    required this.available,
  });

  // Mengonversi Map menjadi StockItem
  factory StockItem.fromMap(Map<String, dynamic> map) {
    return StockItem(
      id: map['id'],
      stok: map['stok'],
      available: map['available'],
    );
  }
}
