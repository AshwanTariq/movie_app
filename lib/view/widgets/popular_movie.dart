import 'package:flutter/material.dart';

import '../../model/MovieModel.dart';
import '../../provider/movie_api_provider.dart';
import 'movie_widget.dart';

class PopMoviesList extends StatelessWidget {
  PopMoviesList({super.key});

  final MovieApiProviderImpl _apiProviderImpl = MovieApiProviderImpl();
  List<Movie> list = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: FutureBuilder<List<Movie>>(
        future: _apiProviderImpl.getPopularMovies(),
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
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/detail",
                        arguments: movies[index].id);
                  },
                  child: MovieWidget(
                    imageUrl: movies[index].posterPath,
                    title: movies[index].title,
                    rating: movies[index].voteAverage.toString(),
                    genres: movies[index].genreIds,
                    isPopular: true,
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
