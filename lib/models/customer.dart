class Customer {
  final String name;
  final String contact;
  final String tujuan;

  const Customer({
    required this.name,
    required this.contact,
    required this.tujuan,
  });

  static fromJson(i) {}
}

class Customers {
  final int id;
  final String customersName;
  final String phone;
  final String provinceCode;
  final String regencyCode;
  final String districtCode;
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

class CustomersKp {
  final int id;
  final String customersName;
  final String phone;
  final String provinceCode;
  final String regencyCode;
  final String districtCode;
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

  CustomersKp({
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

  factory CustomersKp.fromJson(Map<String, dynamic> json) {
    return CustomersKp(
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

class CustomersPb {
  final int id;
  final String customersName;
  final String phone;
  final String provinceCode;
  final String regencyCode;
  final String districtCode;
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

  CustomersPb({
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

  factory CustomersPb.fromJson(Map<String, dynamic> json) {
    return CustomersPb(
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
