class TransaksiPoKendaraan {
  final int id;
  final String jenisKendaraan;
  final String noPolisi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic>
      delivery; // Assuming 'delivery' is a list of dynamic objects for now

  TransaksiPoKendaraan({
    required this.id,
    required this.jenisKendaraan,
    required this.noPolisi,
    required this.createdAt,
    required this.updatedAt,
    required this.delivery,
  });

  factory TransaksiPoKendaraan.fromJson(Map<String, dynamic> json) {
    return TransaksiPoKendaraan(
      id: json['id'],
      jenisKendaraan: json['jenis_kendaraan'],
      noPolisi: json['no_polisi'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      delivery: List<dynamic>.from(json['delivery'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenis_kendaraan': jenisKendaraan,
      'no_polisi': noPolisi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'delivery': delivery,
    };
  }

  map(TransaksiPoKendaraan Function(dynamic json) param0) {}
}
