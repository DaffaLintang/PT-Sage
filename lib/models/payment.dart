class Payment {
  final int id;
  final String kodePengiriman;
  final int? jumlahBayar;
  final int kurangBayar;
  final String statusPembayaran;
  final int jatuhTempo;
  final String createdAt;
  final String updatedAt;
  final Delivery delivery;

  Payment({
    required this.id,
    required this.kodePengiriman,
    this.jumlahBayar,
    required this.kurangBayar,
    required this.statusPembayaran,
    required this.jatuhTempo,
    required this.createdAt,
    required this.updatedAt,
    required this.delivery,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      kodePengiriman: json['kode_pengiriman'],
      jumlahBayar: json['jumlah_bayar'],
      kurangBayar: json['kurang_bayar'],
      statusPembayaran: json['status_pembayaran'],
      jatuhTempo: json['jatuh_tempo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      delivery: Delivery.fromJson(json['delivery']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode_pengiriman': kodePengiriman,
      'jumlah_bayar': jumlahBayar,
      'kurang_bayar': kurangBayar,
      'status_pembayaran': statusPembayaran,
      'jatuh_tempo': jatuhTempo,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'delivery': delivery.toJson(),
    };
  }
}

class Delivery {
  final String kodePengiriman;
  final int customerId;
  final int kendaraanId;
  final String kodePo;
  final String tanggalPengiriman;
  final String namaSopir;
  final int jumlahDikirim;
  final int jumlahKurang;
  final String createdAt;
  final String updatedAt;
  final PurchaseOrder purchaseOrder;

  Delivery({
    required this.kodePengiriman,
    required this.customerId,
    required this.kendaraanId,
    required this.kodePo,
    required this.tanggalPengiriman,
    required this.namaSopir,
    required this.jumlahDikirim,
    required this.jumlahKurang,
    required this.createdAt,
    required this.updatedAt,
    required this.purchaseOrder,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      kodePengiriman: json['kode_pengiriman'],
      customerId: json['customer_id'],
      kendaraanId: json['kendaraan_id'],
      kodePo: json['kode_po'],
      tanggalPengiriman: json['tanggal_pengiriman'],
      namaSopir: json['nama_sopir'],
      jumlahDikirim: json['jumlah_dikirim'],
      jumlahKurang: json['jumlah_kurang'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      purchaseOrder: PurchaseOrder.fromJson(json['purchase_order']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_pengiriman': kodePengiriman,
      'customer_id': customerId,
      'kendaraan_id': kendaraanId,
      'kode_po': kodePo,
      'tanggal_pengiriman': tanggalPengiriman,
      'nama_sopir': namaSopir,
      'jumlah_dikirim': jumlahDikirim,
      'jumlah_kurang': jumlahKurang,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'purchase_order': purchaseOrder.toJson(),
    };
  }
}

class PurchaseOrder {
  final String kodePo;
  final int usersId;
  final int customersId;
  final int productId;
  final String quantity;
  final String totalPrice;
  final String paymentTerm;
  final String dp;
  final String dpAmount;
  final String status;
  final String deliveryStatus;
  final String discount;
  final String discountType;
  final String deliveryDate;
  final Customers customer;
  final String createdAt;
  final String updatedAt;

  PurchaseOrder({
    required this.kodePo,
    required this.usersId,
    required this.customersId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.paymentTerm,
    required this.dp,
    required this.dpAmount,
    required this.status,
    required this.deliveryStatus,
    required this.discount,
    required this.discountType,
    required this.deliveryDate,
    required this.customer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    return PurchaseOrder(
      kodePo: json['kode_po'],
      usersId: json['users_id'],
      customersId: json['customers_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      paymentTerm: json['payment_term'],
      dp: json['dp'],
      dpAmount: json['dp_amount'] ?? "0",
      status: json['status'],
      deliveryStatus: json['delivery_status'],
      discount: json['discount'] ?? "-",
      discountType: json['discount_type'] ?? "-",
      deliveryDate: json['delivery_date'],
      customer: Customers.fromJson(json['customer']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_po': kodePo,
      'users_id': usersId,
      'customers_id': customersId,
      'product_id': productId,
      'quantity': quantity,
      'total_price': totalPrice,
      'payment_term': paymentTerm,
      'dp': dp,
      'dp_amount': dpAmount,
      'status': status,
      'delivery_status': deliveryStatus,
      'discount': discount,
      'discount_type': discountType,
      'delivery_date': deliveryDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Customers {
  final int id;
  final String customersName;
  final String phone;
  final int provinceCode;
  final int regencyCode;
  final int districtCode;
  final String address;
  final String noMoU;
  final String activePeriodFrom;
  final String activePeriodTo;
  final String latitude;
  final String longitude;
  final String statusApprove;
  final int usersId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customers({
    required this.id,
    required this.customersName,
    required this.phone,
    required this.provinceCode,
    required this.regencyCode,
    required this.districtCode,
    required this.address,
    required this.noMoU,
    required this.activePeriodFrom,
    required this.activePeriodTo,
    required this.latitude,
    required this.longitude,
    required this.statusApprove,
    required this.usersId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      id: json['id'] ?? 0, // Misalnya default 0 jika null
      customersName: json['customers_name'] ??
          '', // Defaultkan menjadi string kosong jika null
      phone: json['phone'] ?? '', // Defaultkan menjadi string kosong jika null
      provinceCode: json['province_code'] ?? '',
      regencyCode: json['regency_code'] ?? '',
      districtCode: json['district_code'] ?? '',
      address: json['address'] ?? '',
      noMoU: json['noMoU'] ?? '',
      activePeriodFrom: json['active_period_from'] ?? '',
      activePeriodTo: json['active_period_to'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      statusApprove: json['status_approve'] ?? '',
      usersId: json['users_id'] ?? 0, // Defaultkan menjadi 0 jika null
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customers_name': customersName,
      'phone': phone,
      'province_code': provinceCode,
      'regency_code': regencyCode,
      'district_code': districtCode,
      'address': address,
      'noMoU': noMoU,
      'active_period_from': activePeriodFrom,
      'active_period_to': activePeriodTo,
      'latitude': latitude,
      'longitude': longitude,
      'status_approve': statusApprove,
      'users_id': usersId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
