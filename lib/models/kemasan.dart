class Kemasan {
  final int id;
  final int weight;
  final DateTime createdAt;
  final DateTime updatedAt;

  Kemasan({
    required this.id,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kemasan.fromJson(Map<String, dynamic> json) {
    return Kemasan(
      id: json['id'],
      weight: json['weight'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class KemasanList {
  final List<Kemasan> kemasan;

  KemasanList({required this.kemasan});

  factory KemasanList.fromJson(Map<String, dynamic> json) {
    var list = json['kemasan'] as List;
    List<Kemasan> kemasanList = list.map((i) => Kemasan.fromJson(i)).toList();
    return KemasanList(kemasan: kemasanList);
  }

  Map<String, dynamic> toJson() {
    return {
      'kemasan': kemasan.map((item) => item.toJson()).toList(),
    };
  }
}
