import 'package:movie_app/features/home/domain/entities/movie.dart';

abstract class CategoryRepository {
  Future<List<Movie>> getMoviesByCategory(int? genreId);
}
