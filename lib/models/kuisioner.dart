import 'dart:convert';

class KuisionerKpList {
  final List<KuisionerKp> kuisionerList;

  KuisionerKpList({
    required this.kuisionerList,
  });

  factory KuisionerKpList.fromJson(Map<String, dynamic> json) {
    return KuisionerKpList(
      kuisionerList: List<KuisionerKp>.from(
          json['quisioner'].map((e) => KuisionerKp.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quisioner': kuisionerList.map((q) => q.toJson()).toList(),
    };
  }
}

class KuisionerKp {
  int id;
  int jenisKuisionerId;
  String pertanyaan;
  DateTime createdAt;
  DateTime updatedAt;
  List<SubKuisionerKp> subKuisioner;

  KuisionerKp({
    required this.id,
    required this.jenisKuisionerId,
    required this.pertanyaan,
    required this.createdAt,
    required this.updatedAt,
    required this.subKuisioner,
  });

  factory KuisionerKp.fromJson(Map<String, dynamic> json) {
    return KuisionerKp(
      id: json['id'],
      jenisKuisionerId: json['jenis_kuisioner_id'],
      pertanyaan: json['pertanyaan'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      subKuisioner: List<SubKuisionerKp>.from(
          json['sub_kuisioner'].map((s) => SubKuisionerKp.fromJson(s))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenis_kuisioner_id': jenisKuisionerId,
      'pertanyaan': pertanyaan,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sub_kuisioner': List<dynamic>.from(subKuisioner.map((s) => s.toJson())),
    };
  }
}

class SubKuisionerKp {
  int id;
  int kuisionerId;
  String subPertanyaan;
  DateTime createdAt;
  DateTime updatedAt;

  SubKuisionerKp({
    required this.id,
    required this.kuisionerId,
    required this.subPertanyaan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubKuisionerKp.fromJson(Map<String, dynamic> json) {
    return SubKuisionerKp(
      id: json['id'],
      kuisionerId: json['kuisioner_id'],
      subPertanyaan: json['sub_pertanyaan'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kuisioner_id': kuisionerId,
      'sub_pertanyaan': subPertanyaan,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class KuisionerPbList {
  final List<KuisionerKp> kuisionerList;

  KuisionerPbList({
    required this.kuisionerList,
  });

  factory KuisionerPbList.fromJson(Map<String, dynamic> json) {
    return KuisionerPbList(
      kuisionerList: List<KuisionerKp>.from(
        json['data'].map((e) => KuisionerKp.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': kuisionerList.map((q) => q.toJson()).toList(),
    };
  }
}

class KuisionerPb {
  int id;
  int jenisKuisionerId;
  String pertanyaan;
  DateTime createdAt;
  DateTime updatedAt;
  List<SubKuisionerPb> subKuisioner;

  KuisionerPb({
    required this.id,
    required this.jenisKuisionerId,
    required this.pertanyaan,
    required this.createdAt,
    required this.updatedAt,
    required this.subKuisioner,
  });

  factory KuisionerPb.fromJson(Map<String, dynamic> json) {
    return KuisionerPb(
      id: json['id'],
      jenisKuisionerId: json['jenis_kuisioner_id'],
      pertanyaan: json['pertanyaan'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      subKuisioner: List<SubKuisionerPb>.from(
        json['sub_kuisioner'].map((s) => SubKuisionerPb.fromJson(s)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenis_kuisioner_id': jenisKuisionerId,
      'pertanyaan': pertanyaan,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sub_kuisioner': subKuisioner.map((s) => s.toJson()).toList(),
    };
  }
}

class SubKuisionerPb {
  int id;
  int kuisionerId;
  String subPertanyaan;
  DateTime createdAt;
  DateTime updatedAt;
  Map<String, String> nilaiDeskripsi;

  SubKuisionerPb({
    required this.id,
    required this.kuisionerId,
    required this.subPertanyaan,
    required this.createdAt,
    required this.updatedAt,
    required this.nilaiDeskripsi,
  });

  factory SubKuisionerPb.fromJson(Map<String, dynamic> json) {
    return SubKuisionerPb(
      id: json['id'],
      kuisionerId: json['kuisioner_id'],
      subPertanyaan: json['sub_pertanyaan'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      nilaiDeskripsi: Map<String, String>.from(json['nilai_deskripsi']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kuisioner_id': kuisionerId,
      'sub_pertanyaan': subPertanyaan,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'nilai_deskripsi': nilaiDeskripsi,
    };
  }
}

class PbData {
  List<int> subKuisionerIds;
  List<String> selectedValues;
  List<String> catatanValues;

  PbData(this.subKuisionerIds, this.selectedValues, this.catatanValues);
}

class KpData {
  List<int> subKuisionerIds;
  List<String> selectedValues;

  KpData(this.subKuisionerIds, this.selectedValues);
}
