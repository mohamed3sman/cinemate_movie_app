import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> searchMovies(String query);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    return _getMovies(ApiConstants.popularMovies);
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    return _getMovies(ApiConstants.topRatedMovies);
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    return _getMovies(ApiConstants.trendingMovies);
  }

  Future<List<MovieModel>> _getMovies(String endpoint) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}$endpoint',
      queryParameters: {'api_key': ApiConstants.apiKey},
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies from $endpoint');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.searchMovies}',
      queryParameters: {
        'api_key': ApiConstants.apiKey,
        'query': query,
      },
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
