import '../../domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.id,
    required super.title,
    required super.backdropPath,
    required super.posterPath,
    required super.releaseDate,
    required super.overview,
    required super.studio,
    required super.voteAverage,
    required super.cast,
    required super.genres,
    required super.runtime,
    required super.tagline,
    required super.productionCompanies,
    required super.budget,
    required super.revenue,
    super.trailerKey,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    // Extract trailer key
    String? trailerKey;
    final videos = json['videos']?['results'] as List?;
    if (videos != null && videos.isNotEmpty) {
      final trailer = videos.firstWhere(
        (v) => v['type'] == 'Trailer' && v['site'] == 'YouTube',
        orElse: () => videos.firstWhere(
          (v) => v['site'] == 'YouTube',
          orElse: () => null,
        ),
      );
      trailerKey = trailer?['key'];
    }

    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      studio: (json['production_companies'] as List?)?.isNotEmpty == true
          ? json['production_companies'][0]['name']
          : 'Unknown Studio',
      voteAverage: (json['vote_average'] as num).toDouble(),
      genres: (json['genres'] as List?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      runtime: json['runtime'] ?? 0,
      tagline: json['tagline'] ?? '',
      productionCompanies: (json['production_companies'] as List?)
              ?.map((company) => company['name'] as String)
              .toList() ??
          [],
      budget: json['budget'] ?? 0,
      revenue: json['revenue'] ?? 0,
      trailerKey: trailerKey,
      cast: (json['credits']?['cast'] as List?)
              ?.map((member) => CastMemberModel.fromJson(member))
              .toList() ??
          [],
    );
  }
}

class CastMemberModel extends CastMember {
  const CastMemberModel({
    required super.name,
    required super.role,
    required super.imageUrl,
  });

  factory CastMemberModel.fromJson(Map<String, dynamic> json) {
    return CastMemberModel(
      name: json['name'] ?? '',
      role: json['character'] ?? '',
      imageUrl: json['profile_path'] ?? '',
    );
  }
}
