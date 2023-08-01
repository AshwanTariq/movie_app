class ProductionCompany {
  final int id;
  final String name;
  final String originCountry;
  final String logo_path;

  ProductionCompany(
      {required this.id,
      required this.name,
      required this.originCountry,
      required this.logo_path});
  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      name: json['name'],
      originCountry: json['origin_country'],
      logo_path: json['logo_path'] ?? "",
    );
  }
}
