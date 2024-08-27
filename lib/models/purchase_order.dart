import 'dart:ffi';

class PurchaseOrder {
  String kodePo;
  int usersId;
  int customersId;
  String customersName;
  int productId;
  String productName;
  int quantity;
  int totalPrice;
  String paymentTerm;
  String dp;
  int dpAmount;
  String status;
  double? diskon;
  String? diskonType;
  String? statusPengiriman;
  DateTime? tanggalPengiriman;
  List<Kemasan> kemasan;
  DateTime createdAt;
  DateTime updatedAt;

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
    this.diskon,
    this.diskonType,
    this.statusPengiriman,
    this.tanggalPengiriman,
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
      quantity: int.parse(json['quantity']),
      totalPrice: int.parse(json['total_price']),
      paymentTerm: json['payment_term'],
      dp: json['dp'],
      dpAmount: int.parse(json['dp_amount']),
      status: json['status'],
      diskon: json['diskon'] != null ? double.tryParse(json['diskon']) : null,
      diskonType: json['diskon_type'],
      statusPengiriman: json['status_pengiriman'],
      tanggalPengiriman: json['tanggal_pengiriman'] != null
          ? DateTime.parse(json['tanggal_pengiriman'])
          : null,
      kemasan: List<Kemasan>.from(
        json['kemasan'].map((x) => Kemasan.fromJson(x)),
      ),
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
      'quantity': quantity.toString(),
      'total_price': totalPrice.toString(),
      'payment_term': paymentTerm,
      'dp': dp,
      'dp_amount': dpAmount.toString(),
      'status': status,
      'diskon': diskon?.toString(),
      'diskon_type': diskonType,
      'status_pengiriman': statusPengiriman,
      'tanggal_pengiriman': tanggalPengiriman?.toIso8601String(),
      'kemasan': List<dynamic>.from(kemasan.map((x) => x.toJson())),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Kemasan {
  int kemasanId;
  int berat;
  int quantity;

  Kemasan({
    required this.kemasanId,
    required this.berat,
    required this.quantity,
  });

  factory Kemasan.fromJson(Map<String, dynamic> json) {
    return Kemasan(
      kemasanId: json['kemasan_id'],
      berat: json['berat'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kemasan_id': kemasanId,
      'berat': berat,
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
