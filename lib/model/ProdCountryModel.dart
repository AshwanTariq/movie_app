class ProductionCountry {
  final String iso_3166_1;
  final String name;

  ProductionCountry({
    required this.iso_3166_1,
    required this.name,
  });
  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso_3166_1: json['iso_3166_1'],
      name: json['name'],
    );
  }
}
