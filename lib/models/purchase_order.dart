class PurchaseOrder {
  final String kodePo;
  final int usersId;
  final int customersId;
  final String customersName;
  final int productId;
  final String productName;
  final String quantity;
  final String totalPrice;
  final String paymentTerm;
  final String dp;
  final String dpAmount;
  final String status;
  final String? diskon;
  final String diskonType;
  final String statusPengiriman;
  final String? tanggalPengiriman;
  final List<Kemasan> kemasan;
  final DateTime createdAt;
  final DateTime updatedAt;

  PurchaseOrder({
    required this.kodePo,
    required this.usersId,
    required this.customersId,
    required this.customersName,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.paymentTerm,
    required this.dp,
    required this.dpAmount,
    required this.status,
    required this.diskon,
    required this.diskonType,
    required this.statusPengiriman,
    required this.tanggalPengiriman,
    required this.kemasan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    return PurchaseOrder(
      kodePo: json['kode_po'],
      usersId: json['users_id'],
      customersId: json['customers_id'],
      customersName: json['customers_name'],
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      paymentTerm: json['payment_term'],
      dp: json['dp'],
      dpAmount: json['dp_amount'],
      status: json['status'],
      diskon: json['diskon'],
      diskonType: json['diskon_type'],
      statusPengiriman: json['status_pengiriman'],
      tanggalPengiriman: json['tanggal_pengiriman'],
      kemasan: (json['kemasan'] as List)
          .map((item) => Kemasan.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_po': kodePo,
      'users_id': usersId,
      'customers_id': customersId,
      'customers_name': customersName,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'total_price': totalPrice,
      'payment_term': paymentTerm,
      'dp': dp,
      'dp_amount': dpAmount,
      'status': status,
      'diskon': diskon,
      'diskon_type': diskonType,
      'status_pengiriman': statusPengiriman,
      'tanggal_pengiriman': tanggalPengiriman,
      'kemasan': kemasan.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Kemasan {
  final int kemasanId;
  final int quantity;

  Kemasan({
    required this.kemasanId,
    required this.quantity,
  });

  factory Kemasan.fromJson(Map<String, dynamic> json) {
    return Kemasan(
      kemasanId: json['kemasan_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kemasan_id': kemasanId,
      'quantity': quantity,
    };
  }
}

class PurchaseOrderList {
  final List<PurchaseOrder> orders;

  PurchaseOrderList({required this.orders});

  factory PurchaseOrderList.fromJson(List<dynamic> json) {
    return PurchaseOrderList(
      orders: json.map((item) => PurchaseOrder.fromJson(item)).toList(),
    );
  }

  List<dynamic> toJson() {
    return orders.map((order) => order.toJson()).toList();
  }
}
