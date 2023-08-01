class SpokenLanguage {
  final String englishName;
  final String iso_639_1;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });
  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'],
      iso_639_1: json['iso_639_1'],
      name: json['name'],
    );
  }
}
