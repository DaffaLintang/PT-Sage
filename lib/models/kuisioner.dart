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

class SurveyData {
  final List<DataPerAspek> dataPerAspek;
  final CountJawaban totalJawabanAll;
  final List<IndeksKepuasan> indeksKepuasan;
  final CountJawaban totalIndeksKeseluruhan;
  final String totalPercentage;

  SurveyData({
    required this.dataPerAspek,
    required this.totalJawabanAll,
    required this.indeksKepuasan,
    required this.totalIndeksKeseluruhan,
    required this.totalPercentage,
  });

  factory SurveyData.fromJson(Map<String, dynamic> json) {
    return SurveyData(
      dataPerAspek: (json['dataPerAspek'] as List<dynamic>)
          .map((e) => DataPerAspek.fromJson(e))
          .toList(),
      totalJawabanAll: CountJawaban.fromJson(json['totalJawabanAll']),
      indeksKepuasan: (json['indeksKepuasan'] as List<dynamic>)
          .map((e) => IndeksKepuasan.fromJson(e))
          .toList(),
      totalIndeksKeseluruhan:
          CountJawaban.fromJson(json['totalIndeksKeseluruhan']),
      totalPercentage: json['totalPercentage'],
    );
  }
}

class DataPerAspek {
  final int index;
  final String aspek;
  final CountJawaban countJawaban;
  final int totalJawaban;

  DataPerAspek({
    required this.index,
    required this.aspek,
    required this.countJawaban,
    required this.totalJawaban,
  });

  factory DataPerAspek.fromJson(Map<String, dynamic> json) {
    return DataPerAspek(
      index: json['index'],
      aspek: json['aspek'],
      countJawaban: CountJawaban.fromJson(json['countJawaban']),
      totalJawaban: json['totalJawaban'],
    );
  }
}

class CountJawaban {
  final int one;
  final int two;
  final int three;
  final int four;
  final int five;

  CountJawaban({
    required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
  });

  factory CountJawaban.fromJson(Map<String, dynamic> json) {
    return CountJawaban(
      one: json['1'],
      two: json['2'],
      three: json['3'],
      four: json['4'],
      five: json['5'],
    );
  }
}

class IndeksKepuasan {
  final int index;
  final String aspek;
  final CountJawaban indeksAspek;
  final int totalIndeks;
  final double indeksKepuasanAspek;
  final String presentase;

  IndeksKepuasan({
    required this.index,
    required this.aspek,
    required this.indeksAspek,
    required this.totalIndeks,
    required this.indeksKepuasanAspek,
    required this.presentase,
  });

  factory IndeksKepuasan.fromJson(Map<String, dynamic> json) {
    return IndeksKepuasan(
      index: json['index'],
      aspek: json['aspek'],
      indeksAspek: CountJawaban.fromJson(json['indeksAspek']),
      totalIndeks: json['totalIndeks'],
      indeksKepuasanAspek: json['indeksKepuasanAspek'].toDouble(),
      presentase: json['presentase'],
    );
  }
}

class CompetitorResponse {
  bool success;
  List<Competitor> data;

  CompetitorResponse({
    required this.success,
    required this.data,
  });

  factory CompetitorResponse.fromJson(Map<String, dynamic> json) {
    return CompetitorResponse(
      success: json['success'],
      data: List<Competitor>.from(
          json['data'].map((x) => Competitor.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class Competitor {
  int id;
  int usersId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Competitor({
    required this.id,
    required this.usersId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Competitor.fromJson(Map<String, dynamic> json) {
    return Competitor(
      id: json['id'],
      usersId: json['users_id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
