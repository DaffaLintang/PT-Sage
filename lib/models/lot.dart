class ProductLot {
  int id;
  int productId;
  String lotNumber;
  String quantity;
  int usersId;
  DateTime createdAt;
  DateTime updatedAt;

  ProductLot({
    required this.id,
    required this.productId,
    required this.lotNumber,
    required this.quantity,
    required this.usersId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a ProductLot object from JSON
  factory ProductLot.fromJson(Map<String, dynamic> json) {
    return ProductLot(
      id: json['id'],
      productId: json['product_id'],
      lotNumber: json['lot_number'],
      quantity: json['quantity'],
      usersId: json['users_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
