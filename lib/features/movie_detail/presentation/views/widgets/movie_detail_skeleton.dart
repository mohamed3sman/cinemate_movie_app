import 'package:movie_app/features/movie_detail/domain/entities/movie_detail.dart';

class MovieDetailSkeleton extends MovieDetail {
  MovieDetailSkeleton({
    required int movieId,
    String? posterPath,
  }) : super(
          id: movieId,
          title: 'Movie Title Loading',
          backdropPath: '',
          posterPath: posterPath ?? '',
          releaseDate: '2024-01-01',
          overview:
              'Overview loading... this is a placeholder for the movie description that will be replaced once the data is loaded from the API.',
          studio: 'Studio Name',
          voteAverage: 0.0,
          genres: const ['Action', 'Drama'],
          runtime: 120,
          tagline: 'Sample Tagline for Loading State',
          productionCompanies: const ['Company A', 'Company B'],
          budget: 100000000,
          revenue: 500000000,
          cast: List.generate(
            4,
            (index) => const CastMember(
              name: 'Cast Name',
              role: 'Character Role',
              imageUrl: '',
            ),
          ),
        );
}
