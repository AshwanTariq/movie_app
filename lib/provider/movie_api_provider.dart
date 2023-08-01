import 'package:dio/dio.dart';

import '../model/MovieDetailModel.dart';
import '../model/MovieModel.dart';

abstract class MovieApiProvider {
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> getPopularMovies();
  Future<MovieDetail> getMovieDetail(int movieId);
}

class MovieApiProviderImpl extends MovieApiProvider {
  final Dio _dio = Dio();
  final String _apiKey = "key_here";
  final String _baseUrl = "https://api.themoviedb.org/3";

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final response =
          await _dio.get("$_baseUrl/movie/upcoming", queryParameters: {
        "api_key": _apiKey,
      });

      if (response.statusCode == 200) {
        final results =
            List<Map<String, dynamic>>.from(response.data['results']);
        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception(
            "Failed to fetch upcoming movies: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to fetch upcoming movies: $error");
    }
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final response =
          await _dio.get("$_baseUrl/movie/popular", queryParameters: {
        "api_key": _apiKey,
      });

      if (response.statusCode == 200) {
        final results =
            List<Map<String, dynamic>>.from(response.data['results']);
        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception(
            "Failed to fetch popular movies: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to fetch popular movies: $error");
    }
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieId) async {
    //try {
    final response =
        await _dio.get("$_baseUrl/movie/$movieId", queryParameters: {
      "api_key": _apiKey,
    });

    if (response.statusCode == 200) {
      print(response.data);
      return MovieDetail.fromJson(response.data);
    } else {
      throw Exception(
          "Failed to fetch movie details Parsing: ${response.statusCode}");
    }
    // } catch (error) {
    // throw Exception("Failed to fetch movie details: $error");
    //  }
  }
}
