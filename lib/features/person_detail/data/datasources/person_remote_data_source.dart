import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constants.dart';
import '../models/person_detail_model.dart';

abstract class PersonRemoteDataSource {
  Future<PersonDetailModel> getPersonDetail(int id);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final Dio dio;

  PersonRemoteDataSourceImpl({required this.dio});

  @override
  Future<PersonDetailModel> getPersonDetail(int id) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.personDetail(id)}',
      queryParameters: {
        'api_key': ApiConstants.apiKey,
        'append_to_response': 'movie_credits',
      },
    );
    if (response.statusCode == 200) {
      return PersonDetailModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load person details');
    }
  }
}
