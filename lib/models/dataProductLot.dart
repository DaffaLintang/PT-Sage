class Product {
  final int id;
  final int usersId;
  final String productName;
  final String price;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.usersId,
    required this.productName,
    required this.price,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      usersId: json['users_id'],
      productName: json['product_name'],
      price: json['price'],
      deletedAt: json['deleted_at'],
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
      'deleted_at': deletedAt,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class User {
  final int id;
  final String fullname;
  final String username;
  final String email;
  final int levelsId;
  final String? ttd;
  final String? avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.levelsId,
    this.ttd,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      levelsId: json['levels_id'],
      ttd: json['ttd'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'username': username,
      'email': email,
      'levels_id': levelsId,
      'ttd': ttd,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class InventoryItem {
  final int id;
  final int productId;
  final String lotNumber;
  final String quantity;
  final int usersId;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;
  final User users;

  InventoryItem({
    required this.id,
    required this.productId,
    required this.lotNumber,
    required this.quantity,
    required this.usersId,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.users,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'],
      productId: json['product_id'],
      lotNumber: json['lot_number'],
      quantity: json['quantity'],
      usersId: json['users_id'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['product']),
      users: User.fromJson(json['users']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'lot_number': lotNumber,
      'quantity': quantity,
      'users_id': usersId,
      'deleted_at': deletedAt,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'product': product.toJson(),
      'users': users.toJson(),
    };
  }
}
