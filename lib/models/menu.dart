class Menu {
  int? id;
  String? name;
  String? routeName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Menu({
    this.id,
    this.name,
    this.routeName,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor untuk membuat instance dari JSON
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] as int?,
      name: json['name'] as String?,
      routeName: json['route_name'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Method untuk mengubah instance ke dalam bentuk JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'route_name': routeName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
