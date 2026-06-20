class MovieDetail {
  final int id;
  final String title;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final String studio;
  final double voteAverage;
  final List<CastMember> cast;
  final List<String> genres;
  final int runtime;
  final String tagline;
  final List<String> productionCompanies;
  final int budget;
  final int revenue;
  final String? trailerKey;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
    required this.studio,
    required this.voteAverage,
    required this.cast,
    required this.genres,
    required this.runtime,
    required this.tagline,
    required this.productionCompanies,
    required this.budget,
    required this.revenue,
    this.trailerKey,
  });
}

class CastMember {
  final String name;
  final String role;
  final String imageUrl;

  const CastMember({
    required this.name,
    required this.role,
    required this.imageUrl,
  });
}
