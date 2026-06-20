import 'package:movie_app/features/home/domain/entities/movie.dart';

abstract class HomeRepository {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> searchMovies(String query);
}
