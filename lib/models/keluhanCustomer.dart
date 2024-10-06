class KeluhanCustomer {
  int id;
  String customersName;
  String phone;
  String provinceCode;
  String regencyCode;
  String districtCode;
  String address;
  String noMoU;
  String activePeriodFrom;
  String activePeriodTo;
  String latitude;
  String longitude;
  String statusApprove;
  int usersId;
  String createdAt;
  String updatedAt;
  List<Delivery> delivery;

  KeluhanCustomer({
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
    required this.delivery,
  });

  factory KeluhanCustomer.fromJson(Map<String, dynamic> json) {
    return KeluhanCustomer(
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
      delivery: List<Delivery>.from(
          json['delivery'].map((item) => Delivery.fromJson(item))),
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
      'created_at': createdAt,
      'updated_at': updatedAt,
      'delivery': delivery.map((item) => item.toJson()).toList(),
    };
  }
}

class Delivery {
  String kodePengiriman;
  int customerId;
  int kendaraanId;
  String kodePo;
  String tanggalPengiriman;
  String namaSopir;
  int jumlahDikirim;
  int jumlahKurang;
  String createdAt;
  String updatedAt;

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
    };
  }
}

class KeluhanData {
  int? id;
  int? customerId;
  String? kodeInvoice;
  int? userId;
  String? type;
  String? complaint;
  String? typeNonRetur;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  InvoiceKeluhan? invoice;
  User? user;

  KeluhanData({
    this.id,
    this.customerId,
    this.kodeInvoice,
    this.userId,
    this.type,
    this.complaint,
    this.typeNonRetur,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.invoice,
    this.user,
  });

  factory KeluhanData.fromJson(Map<String, dynamic> json) {
    return KeluhanData(
      id: json['id'],
      customerId: json['customer_id'],
      kodeInvoice: json['kode_invoice'],
      userId: json['user_id'],
      type: json['type'],
      complaint: json['complaint'],
      typeNonRetur: json['type_non_retur'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      invoice: json['invoice'] != null
          ? InvoiceKeluhan.fromJson(json['invoice'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'kode_invoice': kodeInvoice,
      'user_id': userId,
      'type': type,
      'complaint': complaint,
      'type_non_retur': typeNonRetur,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'customer': customer?.toJson(),
      'invoice': invoice?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class Customer {
  int? id;
  String? customersName;
  String? phone;
  String? provinceCode;
  String? regencyCode;
  String? districtCode;
  String? address;
  String? noMoU;
  String? activePeriodFrom;
  String? activePeriodTo;
  String? latitude;
  String? longitude;
  String? statusApprove;
  int? usersId;
  String? createdAt;
  String? updatedAt;

  Customer({
    this.id,
    this.customersName,
    this.phone,
    this.provinceCode,
    this.regencyCode,
    this.districtCode,
    this.address,
    this.noMoU,
    this.activePeriodFrom,
    this.activePeriodTo,
    this.latitude,
    this.longitude,
    this.statusApprove,
    this.usersId,
    this.createdAt,
    this.updatedAt,
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class InvoiceKeluhan {
  String? kodeInvoice;
  String? kodePengiriman;
  String? buktiKirim;
  String? buktiBayar;
  String? createdAt;
  String? updatedAt;

  InvoiceKeluhan({
    this.kodeInvoice,
    this.kodePengiriman,
    this.buktiKirim,
    this.buktiBayar,
    this.createdAt,
    this.updatedAt,
  });

  factory InvoiceKeluhan.fromJson(Map<String, dynamic> json) {
    return InvoiceKeluhan(
      kodeInvoice: json['kode_invoice'],
      kodePengiriman: json['kode_pengiriman'],
      buktiKirim: json['bukti_kirim'],
      buktiBayar: json['bukti_bayar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_invoice': kodeInvoice,
      'kode_pengiriman': kodePengiriman,
      'bukti_kirim': buktiKirim,
      'bukti_bayar': buktiBayar,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class User {
  int? id;
  String? fullname;
  String? username;
  String? email;
  int? levelsId;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.levelsId,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      levelsId: json['levels_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'username': username,
      'email': email,
      'levels_id': levelsId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AdminKeluhanData {
  int? id;
  int? customerId;
  String? kodeInvoice;
  int? userId;
  String? type;
  String? complaint;
  String? typeNonRetur;
  String? createdAt;
  String? updatedAt;
  AdminCustomer? customer;
  AdminInvoiceKeluhan? invoice;
  AdminUser? user;

  AdminKeluhanData({
    this.id,
    this.customerId,
    this.kodeInvoice,
    this.userId,
    this.type,
    this.complaint,
    this.typeNonRetur,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.invoice,
    this.user,
  });

  factory AdminKeluhanData.fromJson(Map<String, dynamic> json) {
    return AdminKeluhanData(
      id: json['id'],
      customerId: json['customer_id'],
      kodeInvoice: json['kode_invoice'],
      userId: json['user_id'],
      type: json['type'],
      complaint: json['complaint'],
      typeNonRetur: json['type_non_retur'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      customer: json['customer'] != null
          ? AdminCustomer.fromJson(json['customer'])
          : null,
      invoice: json['invoice'] != null
          ? AdminInvoiceKeluhan.fromJson(json['invoice'])
          : null,
      user: json['user'] != null ? AdminUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'kode_invoice': kodeInvoice,
      'user_id': userId,
      'type': type,
      'complaint': complaint,
      'type_non_retur': typeNonRetur,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'customer': customer?.toJson(),
      'invoice': invoice?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class AdminCustomer {
  int? id;
  String? customersName;
  String? phone;
  String? provinceCode;
  String? regencyCode;
  String? districtCode;
  String? address;
  String? noMoU;
  String? activePeriodFrom;
  String? activePeriodTo;
  String? latitude;
  String? longitude;
  String? statusApprove;
  int? usersId;
  String? createdAt;
  String? updatedAt;

  AdminCustomer({
    this.id,
    this.customersName,
    this.phone,
    this.provinceCode,
    this.regencyCode,
    this.districtCode,
    this.address,
    this.noMoU,
    this.activePeriodFrom,
    this.activePeriodTo,
    this.latitude,
    this.longitude,
    this.statusApprove,
    this.usersId,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminCustomer.fromJson(Map<String, dynamic> json) {
    return AdminCustomer(
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AdminInvoiceKeluhan {
  String? kodeInvoice;
  String? kodePengiriman;
  String? buktiKirim;
  String? buktiBayar;
  String? createdAt;
  String? updatedAt;

  AdminInvoiceKeluhan({
    this.kodeInvoice,
    this.kodePengiriman,
    this.buktiKirim,
    this.buktiBayar,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminInvoiceKeluhan.fromJson(Map<String, dynamic> json) {
    return AdminInvoiceKeluhan(
      kodeInvoice: json['kode_invoice'],
      kodePengiriman: json['kode_pengiriman'],
      buktiKirim: json['bukti_kirim'],
      buktiBayar: json['bukti_bayar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_invoice': kodeInvoice,
      'kode_pengiriman': kodePengiriman,
      'bukti_kirim': buktiKirim,
      'bukti_bayar': buktiBayar,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AdminUser {
  int? id;
  String? fullname;
  String? username;
  String? email;
  int? levelsId;
  String? createdAt;
  String? updatedAt;

  AdminUser({
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.levelsId,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      levelsId: json['levels_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'username': username,
      'email': email,
      'levels_id': levelsId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class DetailKeluhan {
  int id;
  int customerId;
  String kodeInvoice;
  int userId;
  String type;
  String complaint;
  String? typeNonRetur;
  DateTime createdAt;
  DateTime updatedAt;
  DetailCustomer customer;
  DetailInvoice invoice;
  DetailUser user;
  Deliverys delivery;

  DetailKeluhan({
    required this.id,
    required this.customerId,
    required this.kodeInvoice,
    required this.userId,
    required this.type,
    required this.complaint,
    this.typeNonRetur,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.invoice,
    required this.user,
    required this.delivery,
  });

  factory DetailKeluhan.fromJson(Map<String, dynamic> json) {
    return DetailKeluhan(
      id: json['id'],
      customerId: json['customer_id'],
      kodeInvoice: json['kode_invoice'],
      userId: json['user_id'],
      type: json['type'],
      complaint: json['complaint'],
      typeNonRetur: json['type_non_retur'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      customer: DetailCustomer.fromJson(json['customer']),
      invoice: DetailInvoice.fromJson(json['invoice']),
      user: DetailUser.fromJson(json['user']),
      delivery: Deliverys.fromJson(json['delivery']),
    );
  }
}

class DetailCustomer {
  int id;
  String customersName;
  String phone;
  String provinceCode;
  String regencyCode;
  String districtCode;
  String address;
  String noMoU;
  DateTime activePeriodFrom;
  DateTime activePeriodTo;
  String latitude;
  String longitude;
  String statusApprove;
  int usersId;
  DateTime createdAt;
  DateTime updatedAt;

  DetailCustomer({
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

  factory DetailCustomer.fromJson(Map<String, dynamic> json) {
    return DetailCustomer(
      id: json['id'],
      customersName: json['customers_name'],
      phone: json['phone'],
      provinceCode: json['province_code'],
      regencyCode: json['regency_code'],
      districtCode: json['district_code'],
      address: json['address'],
      noMoU: json['noMoU'],
      activePeriodFrom: DateTime.parse(json['active_period_from']),
      activePeriodTo: DateTime.parse(json['active_period_to']),
      latitude: json['latitude'],
      longitude: json['longitude'],
      statusApprove: json['status_approve'],
      usersId: json['users_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class DetailInvoice {
  String kodeInvoice;
  String kodePengiriman;
  String? buktiKirim;
  String? buktiBayar;
  DateTime createdAt;
  DateTime updatedAt;

  DetailInvoice({
    required this.kodeInvoice,
    required this.kodePengiriman,
    this.buktiKirim,
    this.buktiBayar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailInvoice.fromJson(Map<String, dynamic> json) {
    return DetailInvoice(
      kodeInvoice: json['kode_invoice'],
      kodePengiriman: json['kode_pengiriman'],
      buktiKirim: json['bukti_kirim'],
      buktiBayar: json['bukti_bayar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class DetailUser {
  int id;
  String fullname;
  String username;
  String email;
  int levelsId;
  DateTime createdAt;
  DateTime updatedAt;

  DetailUser({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.levelsId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailUser.fromJson(Map<String, dynamic> json) {
    return DetailUser(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      levelsId: json['levels_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Deliverys {
  String kodePengiriman;
  int customerId;
  int kendaraanId;
  String kodePo;
  DateTime tanggalPengiriman;
  String namaSopir;
  int jumlahDikirim;
  int jumlahKurang;
  DateTime createdAt;
  DateTime updatedAt;
  String laravelThroughKey;
  PurchaseOrder purchaseOrder;
  List<DetailDelivery> detailDelivery;

  Deliverys({
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
    required this.laravelThroughKey,
    required this.purchaseOrder,
    required this.detailDelivery,
  });

  factory Deliverys.fromJson(Map<String, dynamic> json) {
    var detailDeliveryList = json['detail_delivery'] as List;
    List<DetailDelivery> details =
        detailDeliveryList.map((i) => DetailDelivery.fromJson(i)).toList();

    return Deliverys(
      kodePengiriman: json['kode_pengiriman'],
      customerId: json['customer_id'],
      kendaraanId: json['kendaraan_id'],
      kodePo: json['kode_po'],
      tanggalPengiriman: DateTime.parse(json['tanggal_pengiriman']),
      namaSopir: json['nama_sopir'],
      jumlahDikirim: json['jumlah_dikirim'],
      jumlahKurang: json['jumlah_kurang'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      laravelThroughKey: json['laravel_through_key'],
      purchaseOrder: PurchaseOrder.fromJson(json['purchase_order']),
      detailDelivery: details,
    );
  }
}

class PurchaseOrder {
  String kodePo;
  int usersId;
  int customersId;
  int productId;
  String quantity;
  String totalPrice;
  String paymentTerm;
  String dp;
  String dpAmount;
  String status;
  String deliveryStatus;
  String discount;
  String discountType;
  DateTime deliveryDate;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

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
      dpAmount: json['dp_amount'],
      status: json['status'],
      deliveryStatus: json['delivery_status'],
      discount: json['discount'],
      discountType: json['discount_type'],
      deliveryDate: DateTime.parse(json['delivery_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  int id;
  int usersId;
  String productName;
  String price;
  DateTime createdAt;
  DateTime updatedAt;
  List<Varietas> varietas;

  Product({
    required this.id,
    required this.usersId,
    required this.productName,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.varietas,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var varietasList = json['varietas'] as List;
    List<Varietas> varietas =
        varietasList.map((i) => Varietas.fromJson(i)).toList();

    return Product(
      id: json['id'],
      usersId: json['users_id'],
      productName: json['product_name'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      varietas: varietas,
    );
  }
}

class DetailDelivery {
  int id;
  String kodePengiriman;
  int kemasanId;
  int productLotId;
  int quantity;
  int totalPcs;
  DateTime createdAt;
  DateTime updatedAt;
  ProductLot productLot;

  DetailDelivery({
    required this.id,
    required this.kodePengiriman,
    required this.kemasanId,
    required this.productLotId,
    required this.quantity,
    required this.totalPcs,
    required this.createdAt,
    required this.updatedAt,
    required this.productLot,
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
      productLot: ProductLot.fromJson(json['product_lot']),
    );
  }
}

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

class Varietas {
  int id;
  int usersId;
  String
      varietasName; // Menggunakan 'varietasName' untuk menghindari kebingungan dengan nama kelas
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Varietas({
    required this.id,
    required this.usersId,
    required this.varietasName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Varietas.fromJson(Map<String, dynamic> json) {
    return Varietas(
      id: json['id'],
      usersId: json['users_id'],
      varietasName: json['varietas'], // Menggunakan nama 'varietas' dari JSON
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: Pivot.fromJson(json['pivot']),
    );
  }
}

class Pivot {
  int productId;
  int varietasId;

  Pivot({
    required this.productId,
    required this.varietasId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      productId: json['product_id'],
      varietasId: json['varietas_id'],
    );
  }
}

class Retur {
  final int id;
  final int customerId;
  final String kodeInvoice;
  final int userId;
  final String type;
  final String complaint;
  final String? typeNonRetur;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ReturCustomer customer;
  final ReturInvoice invoice;
  final ReturUser user;

  Retur({
    required this.id,
    required this.customerId,
    required this.kodeInvoice,
    required this.userId,
    required this.type,
    required this.complaint,
    this.typeNonRetur,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.invoice,
    required this.user,
  });

  factory Retur.fromJson(Map<String, dynamic> json) {
    return Retur(
      id: json['id'],
      customerId: json['customer_id'],
      kodeInvoice: json['kode_invoice'],
      userId: json['user_id'],
      type: json['type'],
      complaint: json['complaint'],
      typeNonRetur: json['type_non_retur'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      customer: ReturCustomer.fromJson(json['customer']),
      invoice: ReturInvoice.fromJson(json['invoice']),
      user: ReturUser.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'kode_invoice': kodeInvoice,
      'user_id': userId,
      'type': type,
      'complaint': complaint,
      'type_non_retur': typeNonRetur,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'customer': customer.toJson(),
      'invoice': invoice.toJson(),
      'user': user.toJson(),
    };
  }
}

class ReturCustomer {
  final int id;
  final String customersName;
  final String phone;
  final String provinceCode;
  final String regencyCode;
  final String districtCode;
  final String address;
  final String noMoU;
  final DateTime activePeriodFrom;
  final DateTime activePeriodTo;
  final String latitude;
  final String longitude;
  final String statusApprove;
  final int usersId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReturCustomer({
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

  factory ReturCustomer.fromJson(Map<String, dynamic> json) {
    return ReturCustomer(
      id: json['id'],
      customersName: json['customers_name'],
      phone: json['phone'],
      provinceCode: json['province_code'],
      regencyCode: json['regency_code'],
      districtCode: json['district_code'],
      address: json['address'],
      noMoU: json['noMoU'],
      activePeriodFrom: DateTime.parse(json['active_period_from']),
      activePeriodTo: DateTime.parse(json['active_period_to']),
      latitude: json['latitude'],
      longitude: json['longitude'],
      statusApprove: json['status_approve'],
      usersId: json['users_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
      'active_period_from': activePeriodFrom.toIso8601String(),
      'active_period_to': activePeriodTo.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'status_approve': statusApprove,
      'users_id': usersId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ReturInvoice {
  final String kodeInvoice;
  final String kodePengiriman;
  final String? buktiKirim;
  final String? buktiBayar;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReturInvoice({
    required this.kodeInvoice,
    required this.kodePengiriman,
    this.buktiKirim,
    this.buktiBayar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReturInvoice.fromJson(Map<String, dynamic> json) {
    return ReturInvoice(
      kodeInvoice: json['kode_invoice'],
      kodePengiriman: json['kode_pengiriman'],
      buktiKirim: json['bukti_kirim'],
      buktiBayar: json['bukti_bayar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
    };
  }
}

class ReturUser {
  final int id;
  final String fullname;
  final String username;
  final String email;
  final int levelsId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReturUser({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.levelsId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReturUser.fromJson(Map<String, dynamic> json) {
    return ReturUser(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      levelsId: json['levels_id'],
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class NonRetur {
  final int id;
  final int customerId;
  final String kodeInvoice;
  final int userId;
  final String type;
  final String complaint;
  final String? typeNonRetur;
  final DateTime createdAt;
  final DateTime updatedAt;
  final NonReturCustomer customer;
  final NonReturInvoice invoice;
  final NonReturUser user;

  NonRetur({
    required this.id,
    required this.customerId,
    required this.kodeInvoice,
    required this.userId,
    required this.type,
    required this.complaint,
    this.typeNonRetur,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.invoice,
    required this.user,
  });

  factory NonRetur.fromJson(Map<String, dynamic> json) {
    return NonRetur(
      id: json['id'],
      customerId: json['customer_id'],
      kodeInvoice: json['kode_invoice'],
      userId: json['user_id'],
      type: json['type'],
      complaint: json['complaint'],
      typeNonRetur: json['type_non_retur'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      customer: NonReturCustomer.fromJson(json['customer']),
      invoice: NonReturInvoice.fromJson(json['invoice']),
      user: NonReturUser.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'kode_invoice': kodeInvoice,
      'user_id': userId,
      'type': type,
      'complaint': complaint,
      'type_non_retur': typeNonRetur,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'customer': customer.toJson(),
      'invoice': invoice.toJson(),
      'user': user.toJson(),
    };
  }
}

class NonReturCustomer {
  final int id;
  final String customersName;
  final String phone;
  final String provinceCode;
  final String regencyCode;
  final String districtCode;
  final String address;
  final String noMoU;
  final DateTime activePeriodFrom;
  final DateTime activePeriodTo;
  final String latitude;
  final String longitude;
  final String statusApprove;
  final int usersId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NonReturCustomer({
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

  factory NonReturCustomer.fromJson(Map<String, dynamic> json) {
    return NonReturCustomer(
      id: json['id'],
      customersName: json['customers_name'],
      phone: json['phone'],
      provinceCode: json['province_code'],
      regencyCode: json['regency_code'],
      districtCode: json['district_code'],
      address: json['address'],
      noMoU: json['noMoU'],
      activePeriodFrom: DateTime.parse(json['active_period_from']),
      activePeriodTo: DateTime.parse(json['active_period_to']),
      latitude: json['latitude'],
      longitude: json['longitude'],
      statusApprove: json['status_approve'],
      usersId: json['users_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
      'active_period_from': activePeriodFrom.toIso8601String(),
      'active_period_to': activePeriodTo.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'status_approve': statusApprove,
      'users_id': usersId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class NonReturInvoice {
  final String kodeInvoice;
  final String kodePengiriman;
  final String? buktiKirim;
  final String? buktiBayar;
  final DateTime createdAt;
  final DateTime updatedAt;

  NonReturInvoice({
    required this.kodeInvoice,
    required this.kodePengiriman,
    this.buktiKirim,
    this.buktiBayar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NonReturInvoice.fromJson(Map<String, dynamic> json) {
    return NonReturInvoice(
      kodeInvoice: json['kode_invoice'],
      kodePengiriman: json['kode_pengiriman'],
      buktiKirim: json['bukti_kirim'],
      buktiBayar: json['bukti_bayar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
    };
  }
}

class NonReturUser {
  final int id;
  final String fullname;
  final String username;
  final String email;
  final int levelsId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NonReturUser({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.levelsId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NonReturUser.fromJson(Map<String, dynamic> json) {
    return NonReturUser(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      levelsId: json['levels_id'],
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
