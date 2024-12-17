class Customer {
  final int id;
  final String customersName;
  final String phone;
  final int provinceCode;
  final int regencyCode;
  final int districtCode;
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
  final User users;

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
    required this.users,
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
      activePeriodFrom: DateTime.parse(json['active_period_from']),
      activePeriodTo: DateTime.parse(json['active_period_to']),
      latitude: json['latitude'],
      longitude: json['longitude'],
      statusApprove: json['status_approve'],
      usersId: json['users_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      users: User.fromJson(json['users']),
    );
  }
}

class User {
  final int id;
  final String fullname;
  final String username;
  final String email;
  final int levelsId;
  final String? ttd;
  final String? avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.levelsId,
    this.ttd,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
      levelsId: json['levels_id'],
      ttd: json['ttd'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Province {
  final int id;
  final String name;
  final String altName;
  final double latitude;
  final double longitude;

  Province({
    required this.id,
    required this.name,
    required this.altName,
    required this.latitude,
    required this.longitude,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'],
      altName: json['alt_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Regency {
  final int id;
  final int provinceId;
  final String name;
  final String altName;
  final double latitude;
  final double longitude;

  Regency({
    required this.id,
    required this.provinceId,
    required this.name,
    required this.altName,
    required this.latitude,
    required this.longitude,
  });

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      id: json['id'],
      provinceId: json['province_id'],
      name: json['name'],
      altName: json['alt_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class District {
  final int id;
  final int regencyId;
  final String name;
  final String altName;
  final double latitude;
  final double longitude;

  District({
    required this.id,
    required this.regencyId,
    required this.name,
    required this.altName,
    required this.latitude,
    required this.longitude,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      regencyId: json['regency_id'],
      name: json['name'],
      altName: json['alt_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class CustomerDataResponse {
  final List<Customer> customers;
  final List<Province> provinces;
  final List<Regency> regencies;
  final List<District> districts;

  CustomerDataResponse({
    required this.customers,
    required this.provinces,
    required this.regencies,
    required this.districts,
  });
}
