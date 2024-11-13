class NoPolisiData {
  final int id;
  final String noPolisi;

  NoPolisiData({
    required this.id,
    required this.noPolisi,
  });

  factory NoPolisiData.fromJson(Map<String, dynamic> json) {
    return NoPolisiData(
      id: json['id'],
      noPolisi: json['no_polisi'],
    );
  }
}
