import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/features/movie_detail/data/models/movie_detail_model.dart';

abstract class MovieDetailRemoteDataSource {
  Future<MovieDetailModel> getMovieDetail(int id);
}

class MovieDetailRemoteDataSourceImpl implements MovieDetailRemoteDataSource {
  final Dio dio;

  MovieDetailRemoteDataSourceImpl({required this.dio});

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.movieDetail(id)}',
      queryParameters: {
        'api_key': ApiConstants.apiKey,
        'append_to_response': 'credits,videos',
      },
    );

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load movie detail');
    }
  }
}
