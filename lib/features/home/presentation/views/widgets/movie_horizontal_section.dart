import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/features/home/presentation/views/widgets/movie_card.dart';
import 'package:movie_app/features/movie_detail/presentation/views/movie_detail_view.dart';

class MovieHorizontalSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final bool isLoading;

  const MovieHorizontalSection({
    super.key,
    required this.title,
    required this.movies,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(title, style: AppTextStyles.font20WhiteBold),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: isLoading ? 5 : movies.length,
            itemBuilder: (context, index) {
              final movie = isLoading
                  ? const Movie(
                      id: 0,
                      title: 'Loading Title',
                      posterPath: '',
                      backdropPath: '',
                      releaseDate: '2024',
                      overview: '',
                      voteAverage: 0,
                    )
                  : movies[index];
              final heroTag = '${movie.id}_$title';
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  width: 135,
                  child: MovieCard(
                    movie: movie,
                    heroTag: heroTag,
                    onTap: () {
                      if (!isLoading) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailView(
                              movieId: movie.id,
                              posterPath: movie.posterPath,
                              heroTag: heroTag,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
