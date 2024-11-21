class TransaksiDelivery {
  final String kodePengiriman;
  final String kodePo;
  final int customerId;
  final String tanggalPengiriman;
  final int kendaraanId;
  final int nomorPolisiId;
  final String namaSopir;
  final int jumlahDikirim;
  final int jumlahKurang;
  final String createdAt;
  final String updatedAt;
  final TransaksiKendaraan kendaraan;
  final List<DetailDelivery> detailDelivery;
  final PurchaseOrder purchaseOrder;
  final Customer customer;

  TransaksiDelivery({
    required this.kodePengiriman,
    required this.kodePo,
    required this.customerId,
    required this.tanggalPengiriman,
    required this.kendaraanId,
    required this.nomorPolisiId,
    required this.namaSopir,
    required this.jumlahDikirim,
    required this.jumlahKurang,
    required this.createdAt,
    required this.updatedAt,
    required this.kendaraan,
    required this.detailDelivery,
    required this.purchaseOrder,
    required this.customer,
  });

  factory TransaksiDelivery.fromJson(Map<String, dynamic> json) {
    return TransaksiDelivery(
      kodePengiriman: json['kode_pengiriman'],
      kodePo: json['kode_po'],
      customerId: json['customer_id'],
      tanggalPengiriman: json['tanggal_pengiriman'],
      kendaraanId: json['kendaraan_id'],
      nomorPolisiId: json['nomor_polisi_id'],
      namaSopir: json['nama_sopir'],
      jumlahDikirim: json['jumlah_dikirim'],
      jumlahKurang: json['jumlah_kurang'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      kendaraan: TransaksiKendaraan.fromJson(json['kendaraan']),
      detailDelivery: (json['detail_delivery'] as List)
          .map((item) => DetailDelivery.fromJson(item))
          .toList(),
      purchaseOrder: PurchaseOrder.fromJson(json['purchase_order']),
      customer: Customer.fromJson(json['customer']),
    );
  }
}

class TransaksiKendaraan {
  final int id;
  final String jenisKendaraan;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  TransaksiKendaraan({
    required this.id,
    required this.jenisKendaraan,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransaksiKendaraan.fromJson(Map<String, dynamic> json) {
    return TransaksiKendaraan(
      id: json['id'],
      jenisKendaraan: json['jenis_kendaraan'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
  final String createdAt;
  final String updatedAt;

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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
  final String createdAt;
  final String updatedAt;
  final Product product;

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
    required this.product,
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
      discount: json['discount'],
      discountType: json['discount_type'],
      deliveryDate: json['delivery_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final int usersId;
  final String productName;
  final String price;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Customer {
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
  final String createdAt;
  final String updatedAt;

  Customer({
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

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      customersName: json['customers_name'],
      phone: json['phone'],
      provinceCode: json['province_code'],
      regencyCode: json['regency_code'],
      districtCode: json['district_code'],
      address: json['address'],
      noMoU: json['noMoU'],
      activePeriodFrom: json['active_period_from'],
      activePeriodTo: json['active_period_to'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      statusApprove: json['status_approve'],
      usersId: json['users_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
