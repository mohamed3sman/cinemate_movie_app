import 'package:movie_app/features/movie_detail/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movie_detail/domain/repositories/movie_detail_repository.dart';
import 'package:movie_app/features/movie_detail/data/datasources/movie_detail_remote_data_source.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailRemoteDataSource remoteDataSource;

  MovieDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    return await remoteDataSource.getMovieDetail(id);
  }
}
