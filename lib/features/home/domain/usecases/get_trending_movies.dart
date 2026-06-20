import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/features/home/domain/repositories/home_repository.dart';

class GetTrendingMoviesUseCase {
  final HomeRepository repository;

  GetTrendingMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getTrendingMovies();
  }
}
