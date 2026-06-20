import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/features/home/domain/repositories/home_repository.dart';

class GetTopRatedMoviesUseCase {
  final HomeRepository repository;

  GetTopRatedMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getTopRatedMovies();
  }
}
