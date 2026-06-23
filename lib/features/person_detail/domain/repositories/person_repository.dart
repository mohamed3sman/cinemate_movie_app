import 'package:dartz/dartz.dart';
import '../entities/person_detail.dart';

abstract class PersonRepository {
  Future<Either<String, PersonDetail>> getPersonDetail(int id);
}
