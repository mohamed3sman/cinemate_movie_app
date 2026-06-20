class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final String overview;
  final double voteAverage;
  final String studio;

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
    this.studio = 'Marvel Studios',
  });
}
