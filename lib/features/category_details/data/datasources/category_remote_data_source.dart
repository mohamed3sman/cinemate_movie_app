import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<MovieModel>> getMoviesByCategory(int? genreId);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getMoviesByCategory(int? genreId) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.discoverMovies}',
      queryParameters: {
        'api_key': ApiConstants.apiKey,
        if (genreId != null) 'with_genres': genreId,
        'sort_by': 'popularity.desc',
      },
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load category movies');
    }
  }
}
