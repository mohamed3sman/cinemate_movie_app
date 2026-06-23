import 'package:movie_app/features/home/domain/entities/movie.dart';

class PersonDetail {
  final int id;
  final String name;
  final String biography;
  final String birthday;
  final String placeOfBirth;
  final String profilePath;
  final String knownForDepartment;
  final List<Movie> knownForMovies;

  const PersonDetail({
    required this.id,
    required this.name,
    required this.biography,
    required this.birthday,
    required this.placeOfBirth,
    required this.profilePath,
    required this.knownForDepartment,
    required this.knownForMovies,
  });
}
