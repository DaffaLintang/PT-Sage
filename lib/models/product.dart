class Product {
  final int id;
  final int usersId;
  final String productName;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.usersId,
    required this.productName,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      usersId: json['users_id'],
      productName: json['product_name'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'product_name': productName,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
