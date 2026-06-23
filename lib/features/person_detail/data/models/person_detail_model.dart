import 'package:movie_app/features/home/data/models/movie_model.dart';
import '../../domain/entities/person_detail.dart';

class PersonDetailModel extends PersonDetail {
  const PersonDetailModel({
    required super.id,
    required super.name,
    required super.biography,
    required super.birthday,
    required super.placeOfBirth,
    required super.profilePath,
    required super.knownForDepartment,
    required super.knownForMovies,
  });

  factory PersonDetailModel.fromJson(Map<String, dynamic> json) {
    return PersonDetailModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      biography: json['biography'] ?? '',
      birthday: json['birthday'] ?? 'Unknown',
      placeOfBirth: json['place_of_birth'] ?? 'Unknown',
      profilePath: json['profile_path'] ?? '',
      knownForDepartment: json['known_for_department'] ?? 'Acting',
      knownForMovies: (json['movie_credits']?['cast'] as List?)
              ?.map((movie) => MovieModel.fromJson(movie))
              .toList() ??
          [],
    );
  }
}
