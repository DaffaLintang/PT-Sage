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
