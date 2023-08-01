import 'package:flutter/material.dart';

import '../model/MovieDetailModel.dart';
import '../model/MovieModel.dart';
import 'movie_api_provider.dart';

class MovieService {
  final MovieApiProvider _apiProvider = MovieApiProviderImpl();

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      return await _apiProvider.getUpcomingMovies();
    } catch (error) {
      throw Exception("Failed to get upcoming movies: $error");
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      return await _apiProvider.getPopularMovies();
    } catch (error) {
      throw Exception("Failed to get popular movies: $error");
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      return await _apiProvider.getMovieDetail(movieId);
    } catch (error) {
      throw Exception("Failed to get movie details: $error");
    }
  }
}

class MovieApp extends StatelessWidget {
  final MovieService _movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Movie App')),
        body: FutureBuilder<List<Movie>>(
          future: _movieService.getUpcomingMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<Movie> movies = snapshot.data!;
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(movies[index].title),
                    subtitle: Text('Rating: ${movies[index].voteAverage}'),
                    leading: Image.network(
                      movies[index].posterPath,
                      width: 50,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
