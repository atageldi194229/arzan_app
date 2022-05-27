class RegionModel {
  final int id;
  final int? province;
  final String name;
  final int order;

  RegionModel({
    required this.id,
    required this.name,
    this.province,
    this.order = 0,
  });

  factory RegionModel.fromMap(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      province: json['province'] ?? 0,
    );
  }
}
