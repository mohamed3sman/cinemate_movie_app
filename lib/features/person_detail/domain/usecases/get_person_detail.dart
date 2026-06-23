import 'package:dartz/dartz.dart';
import '../entities/person_detail.dart';
import '../repositories/person_repository.dart';

class GetPersonDetailUseCase {
  final PersonRepository repository;

  GetPersonDetailUseCase(this.repository);

  Future<Either<String, PersonDetail>> call(int id) async {
    return await repository.getPersonDetail(id);
  }
}
