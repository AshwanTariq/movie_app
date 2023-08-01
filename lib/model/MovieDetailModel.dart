import 'ProdCompanyModel.dart';
import 'ProdCountryModel.dart';
import 'SpokenLangModel.dart';

class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final String posterPath;
  final String backdropPath;
  final List<dynamic> genreIds;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String homepage;
  final String imdbId;
  final int budget;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.posterPath,
    required this.backdropPath,
    required this.genreIds,
    required this.productionCompanies,
    required this.productionCountries,
    required this.homepage,
    required this.imdbId,
    required this.budget,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
  });
  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      genreIds: List<dynamic>.from(json['genres']) ?? [],
      productionCompanies:
          List<Map<String, dynamic>>.from(json['production_companies'])
              .map((companyData) => ProductionCompany.fromJson(companyData))
              .toList(),
      productionCountries:
          List<Map<String, dynamic>>.from(json['production_countries'])
              .map((countryData) => ProductionCountry.fromJson(countryData))
              .toList(),
      homepage: json['homepage'],
      imdbId: json['imdb_id'],
      budget: json['budget'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: List<Map<String, dynamic>>.from(json['spoken_languages'])
          .map((languageData) => SpokenLanguage.fromJson(languageData))
          .toList(),
      status: json['status'],
      tagline: json['tagline'],
    );
  }
}
