import '../entities/movie_detail.dart';
import '../repositories/movie_detail_repository.dart';

class GetMovieDetailUseCase {
  final MovieDetailRepository repository;

  GetMovieDetailUseCase(this.repository);

  Future<MovieDetail> call(int id) async {
    return await repository.getMovieDetail(id);
  }
}
