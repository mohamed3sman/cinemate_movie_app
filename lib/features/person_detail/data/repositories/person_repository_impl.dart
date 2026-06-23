import 'package:dartz/dartz.dart';
import 'package:movie_app/features/person_detail/domain/entities/person_detail.dart';
import 'package:movie_app/features/person_detail/domain/repositories/person_repository.dart';
import '../datasources/person_remote_data_source.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;

  PersonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, PersonDetail>> getPersonDetail(int id) async {
    try {
      final personDetail = await remoteDataSource.getPersonDetail(id);
      return Right(personDetail);
    } catch (e) {
      return Left('Failed to load person details: ${e.toString()}');
    }
  }
}
