class DetailPayment {
  final int id;
  final int paymentId;
  final String tanggalBayar;
  final int jumlahBayar;
  final String buktiBayar;
  final DateTime createdAt;
  final DateTime updatedAt;

  DetailPayment({
    required this.id,
    required this.paymentId,
    required this.tanggalBayar,
    required this.jumlahBayar,
    required this.buktiBayar,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Payment object from JSON
  factory DetailPayment.fromJson(Map<String, dynamic> json) {
    return DetailPayment(
      id: json['id'],
      paymentId: json['payment_id'],
      tanggalBayar: json['tanggal_bayar'],
      jumlahBayar: json['jumlah_bayar'],
      buktiBayar: json['bukti_bayar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert a Payment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payment_id': paymentId,
      'tanggal_bayar': tanggalBayar,
      'jumlah_bayar': jumlahBayar,
      'bukti_bayar': buktiBayar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// Utility function to parse a list of Payment objects from JSON
List<DetailPayment> paymentListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => DetailPayment.fromJson(json)).toList();
}

// Utility function to convert a list of Payment objects to JSON
List<Map<String, dynamic>> paymentListToJson(List<DetailPayment> payments) {
  return payments.map((payment) => payment.toJson()).toList();
}
