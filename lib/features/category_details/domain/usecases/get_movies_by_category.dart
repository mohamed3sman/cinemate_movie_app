import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/features/category_details/domain/repositories/category_repository.dart';

class GetMoviesByCategoryUseCase {
  final CategoryRepository repository;

  GetMoviesByCategoryUseCase(this.repository);

  Future<List<Movie>> call(int? genreId) async {
    return await repository.getMoviesByCategory(genreId);
  }
}
