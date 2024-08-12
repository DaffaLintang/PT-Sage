class Order {
  final String kodePo;
  final int usersId;
  final int customersId;
  final String customersName;
  final String productName;
  final String quantity;
  final String totalPrice;
  final String paymentTerm;
  final String dp;
  final String dpAmount;
  final String status;
  final String diskon;
  final String diskonType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.kodePo,
    required this.usersId,
    required this.customersId,
    required this.customersName,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.paymentTerm,
    required this.dp,
    required this.dpAmount,
    required this.status,
    required this.diskon,
    required this.diskonType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      kodePo: json['kode_po'],
      usersId: json['users_id'],
      customersId: json['customers_id'],
      customersName: json['customers_name'],
      productName: json['product_name'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      paymentTerm: json['payment_term'],
      dp: json['dp'],
      dpAmount: json['dp_amount'],
      status: json['status'],
      diskon: json['diskon'],
      diskonType: json['diskon_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Orders {
  final List<Order> orders;

  Orders({required this.orders});

  factory Orders.fromJson(List<dynamic> parsedJson) {
    List<Order> orders = parsedJson.map((i) => Order.fromJson(i)).toList();
    return Orders(orders: orders);
  }
}
