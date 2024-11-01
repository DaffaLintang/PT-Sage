import 'dart:convert';

import 'package:pt_sage/models/kendaraan.dart';

class Invoice {
  final String kodeInvoice;
  final String kodePengiriman;
  final String? buktiKirim;
  final String? buktiBayar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Delivery delivery;

  Invoice({
    required this.kodeInvoice,
    required this.kodePengiriman,
    this.buktiKirim,
    this.buktiBayar,
    required this.createdAt,
    required this.updatedAt,
    required this.delivery,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      kodeInvoice: json['kode_invoice'],
      kodePengiriman: json['kode_pengiriman'],
      buktiKirim: json['bukti_kirim'],
      buktiBayar: json['bukti_bayar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      delivery: Delivery.fromJson(json['delivery']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_invoice': kodeInvoice,
      'kode_pengiriman': kodePengiriman,
      'bukti_kirim': buktiKirim,
      'bukti_bayar': buktiBayar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'delivery': delivery.toJson(),
    };
  }
}

class Delivery {
  final String kodePengiriman;
  final int customerId;
  final String kodePo;
  final DateTime tanggalPengiriman;
  final Kendaraan kendaraan;
  final String namaSopir;
  // final String noPolisi;
  final int jumlahDikirim;
  final int jumlahKurang;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DetailDelivery> detailDelivery;
  final PurchaseOrder purchaseOrder;
  final List<Kemasan> kemasan;

  Delivery({
    required this.kodePengiriman,
    required this.customerId,
    required this.kodePo,
    required this.tanggalPengiriman,
    required this.kendaraan,
    required this.namaSopir,
    // required this.noPolisi,
    required this.jumlahDikirim,
    required this.jumlahKurang,
    required this.createdAt,
    required this.updatedAt,
    required this.detailDelivery,
    required this.purchaseOrder,
    required this.kemasan,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      kodePengiriman: json['kode_pengiriman'],
      customerId: json['customer_id'],
      kodePo: json['kode_po'],
      tanggalPengiriman: DateTime.parse(json['tanggal_pengiriman']),
      kendaraan: Kendaraan.fromJson(json['kendaraan'] as Map<String, dynamic>),
      namaSopir: json['nama_sopir'],
      // noPolisi: json['no_polisi'],
      jumlahDikirim: json['jumlah_dikirim'],
      jumlahKurang: json['jumlah_kurang'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      detailDelivery: (json['detail_delivery'] as List<dynamic>)
          .map((e) => DetailDelivery.fromJson(e as Map<String, dynamic>))
          .toList(),
      purchaseOrder: PurchaseOrder.fromJson(json['purchase_order']),
      kemasan: (json['kemasan'] as List)
          .map((item) => Kemasan.fromJson(item))
          .toList(), // Parsing kemasan list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_pengiriman': kodePengiriman,
      'customer_id': customerId,
      'kode_po': kodePo,
      'tanggal_pengiriman': tanggalPengiriman.toIso8601String(),
      'kendaraan': kendaraan,
      'nama_sopir': namaSopir,
      // 'no_polisi': noPolisi,
      'jumlah_dikirim': jumlahDikirim,
      'jumlah_kurang': jumlahKurang,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'detail_delivery': detailDelivery.map((e) => e.toJson()).toList(),
      'purchase_order': purchaseOrder.toJson(),
    };
  }
}

class Kendaraan {
  final int id;
  final String jenisKendaraan;
  final String NoPolisi; // Should be a String, not an int
  final DateTime createdAt;
  final DateTime updatedAt;

  Kendaraan({
    required this.id,
    required this.jenisKendaraan,
    required this.NoPolisi, // Changed to String
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kendaraan.fromJson(Map<String, dynamic> json) {
    return Kendaraan(
      id: json['id'],
      jenisKendaraan: json['jenis_kendaraan'],
      NoPolisi: json['no_polisi'], // Changed to String
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenis_kendaraan': jenisKendaraan,
      'no_polisi': NoPolisi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Kemasan {
  final int kemasanId;
  final int kemasanWeight;
  final int productLotId;
  final int berat;
  final int pcs;

  Kemasan({
    required this.kemasanId,
    required this.kemasanWeight,
    required this.productLotId,
    required this.berat,
    required this.pcs,
  });

  factory Kemasan.fromJson(Map<String, dynamic> json) {
    return Kemasan(
      kemasanId: json['kemasan_id'],
      kemasanWeight: json['kemasan_weight'],
      productLotId: json['product_lot_id'],
      berat: json['berat'],
      pcs: json['pcs'],
    );
  }
}

class DetailDelivery {
  final int id;
  final String kodePengiriman;
  final int kemasanId;
  final int productLotId;
  final int quantity;
  final int totalPcs;
  final DateTime createdAt;
  final DateTime updatedAt;

  DetailDelivery({
    required this.id,
    required this.kodePengiriman,
    required this.kemasanId,
    required this.productLotId,
    required this.quantity,
    required this.totalPcs,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailDelivery.fromJson(Map<String, dynamic> json) {
    return DetailDelivery(
      id: json['id'],
      kodePengiriman: json['kode_pengiriman'],
      kemasanId: json['kemasan_id'],
      productLotId: json['product_lot_id'],
      quantity: json['quantity'],
      totalPcs: json['total_pcs'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode_pengiriman': kodePengiriman,
      'kemasan_id': kemasanId,
      'product_lot_id': productLotId,
      'quantity': quantity,
      'total_pcs': totalPcs,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class PurchaseOrder {
  final String kodePo;
  final int usersId;
  final int customersId;
  final String customersName;
  final String address;
  final String phone;
  final int productId;
  final String productName;
  final String quantity;
  final String price;
  final String totalPrice;
  final String paymentTerm;
  final String dp;
  final String dpAmount;
  final String status;
  final String deliveryStatus;
  final String discount;
  final String discountType;
  final DateTime deliveryDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  PurchaseOrder({
    required this.kodePo,
    required this.usersId,
    required this.customersId,
    required this.customersName,
    required this.address,
    required this.phone,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.paymentTerm,
    required this.dp,
    required this.dpAmount,
    required this.status,
    required this.deliveryStatus,
    required this.discount,
    required this.discountType,
    required this.deliveryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    return PurchaseOrder(
      kodePo: json['kode_po'],
      usersId: json['users_id'],
      customersId: json['customers_id'],
      customersName: json['customers_name'],
      address: json['address'],
      phone: json['phone'],
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price'],
      totalPrice: json['total_price'],
      paymentTerm: json['payment_term'],
      dp: json['dp'],
      dpAmount: json['dp_amount'] ?? "",
      status: json['status'],
      deliveryStatus: json['delivery_status'],
      discount: json['discount'] ?? "Tidak Diskon",
      discountType: json['discount_type'] ?? '',
      deliveryDate: DateTime.parse(json['delivery_date']),
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
      'delivery_status': deliveryStatus,
      'discount': discount,
      'discount_type': discountType,
      'delivery_date': deliveryDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
