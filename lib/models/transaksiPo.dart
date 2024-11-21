class TransaksiPurchaseOrder {
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
  final Customer customer;
  final Product product;
  final User user;
  final List<DetailPo> detailPos;

  TransaksiPurchaseOrder({
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
    required this.customer,
    required this.product,
    required this.user,
    required this.detailPos,
  });

  factory TransaksiPurchaseOrder.fromJson(Map<String, dynamic> json) {
    return TransaksiPurchaseOrder(
      kodePo: json['kode_po'],
      usersId: json['users_id'] ?? "",
      customersId: json['customers_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      paymentTerm: json['payment_term'],
      dp: json['dp'],
      dpAmount: json['dp_amount'] ?? "0",
      status: json['status'],
      deliveryStatus: json['delivery_status'],
      discount: json['discount'] ?? "0",
      discountType: json['discount_type'] ?? "-",
      deliveryDate: json['delivery_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      customer: Customer.fromJson(json['customer']),
      product: Product.fromJson(json['product']),
      user: User.fromJson(json['user']),
      detailPos: (json['detail_pos'] as List)
          .map((item) => DetailPo.fromJson(item))
          .toList(),
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

class User {
  final int id;
  final String fullname;
  final String username;
  final String email;
  final int levelsId;
  final String? ttd;
  final String? avatar;
  final String createdAt;
  final String updatedAt;

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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class DetailPo {
  final int id;
  final String kodePo;
  final int kemasanId;
  final int jumlahKgKemasan;
  final int price;
  final String createdAt;
  final String updatedAt;
  final Kemasan kemasan;

  DetailPo({
    required this.id,
    required this.kodePo,
    required this.kemasanId,
    required this.jumlahKgKemasan,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.kemasan,
  });

  factory DetailPo.fromJson(Map<String, dynamic> json) {
    return DetailPo(
      id: json['id'],
      kodePo: json['kode_po'],
      kemasanId: json['kemasan_id'],
      jumlahKgKemasan: json['jumlah_kg_kemasan'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      kemasan: Kemasan.fromJson(json['kemasan']),
    );
  }
}

class Kemasan {
  final int id;
  final int weight;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Kemasan({
    required this.id,
    required this.weight,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kemasan.fromJson(Map<String, dynamic> json) {
    return Kemasan(
      id: json['id'],
      weight: json['weight'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
