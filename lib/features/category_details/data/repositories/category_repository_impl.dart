import 'package:movie_app/features/category_details/data/datasources/category_remote_data_source.dart';
import 'package:movie_app/features/category_details/domain/repositories/category_repository.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getMoviesByCategory(int? genreId) async {
    return await remoteDataSource.getMoviesByCategory(genreId);
  }
}
