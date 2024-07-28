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
  final String address;
  final String noMoU;
  final String activePeriodFrom;
  final String activePeriodTo;
  final String latitude;
  final String longitude;
  final String phone;
  final String whatsapp;
  final String statusActive;
  final String statusApprove;
  final int usersId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customers({
    required this.id,
    required this.customersName,
    required this.address,
    required this.noMoU,
    required this.activePeriodFrom,
    required this.activePeriodTo,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.whatsapp,
    required this.statusActive,
    required this.statusApprove,
    required this.usersId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      id: json['id'],
      customersName: json['customers_name'],
      address: json['address'],
      noMoU: json['noMoU'],
      activePeriodFrom: json['active_period_from'],
      activePeriodTo: json['active_period_to'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      statusActive: json['status_active'],
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
      'address': address,
      'noMoU': noMoU,
      'active_period_from': activePeriodFrom,
      'active_period_to': activePeriodTo,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'whatsapp': whatsapp,
      'status_active': statusActive,
      'status_approve': statusApprove,
      'users_id': usersId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
