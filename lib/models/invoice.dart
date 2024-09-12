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
}

class Delivery {
  final String kodePengiriman;
  final int customerId;
  final String kodePo;
  final String tanggalPengiriman;
  final String kendaraan;
  final String namaSopir;
  final String noPolisi;
  final int jumlahDikirim;
  final int jumlahKurang;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DetailDelivery> detailDelivery;
  final PurchaseOrder purchaseOrder;

  Delivery({
    required this.kodePengiriman,
    required this.customerId,
    required this.kodePo,
    required this.tanggalPengiriman,
    required this.kendaraan,
    required this.namaSopir,
    required this.noPolisi,
    required this.jumlahDikirim,
    required this.jumlahKurang,
    required this.createdAt,
    required this.updatedAt,
    required this.detailDelivery,
    required this.purchaseOrder,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      kodePengiriman: json['kode_pengiriman'],
      customerId: json['customer_id'],
      kodePo: json['kode_po'],
      tanggalPengiriman: json['tanggal_pengiriman'],
      kendaraan: json['kendaraan'],
      namaSopir: json['nama_sopir'],
      noPolisi: json['no_polisi'],
      jumlahDikirim: json['jumlah_dikirim'],
      jumlahKurang: json['jumlah_kurang'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      detailDelivery: (json['detail_delivery'] as List)
          .map((item) => DetailDelivery.fromJson(item))
          .toList(),
      purchaseOrder: PurchaseOrder.fromJson(json['purchase_order']),
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
  final DateTime createdAt;
  final DateTime updatedAt;

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
      dpAmount: json['dp_amount'],
      status: json['status'],
      deliveryStatus: json['delivery_status'],
      discount: json['discount'],
      discountType: json['discount_type'],
      deliveryDate: json['delivery_date'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
