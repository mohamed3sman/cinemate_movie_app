import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/features/home/presentation/views/widgets/movie_card.dart';
import 'package:movie_app/features/movie_detail/presentation/views/movie_detail_view.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<Movie> results;
  final bool isSearching;
  final String query;

  const SearchResultsGrid({
    super.key,
    required this.results,
    required this.isSearching,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return const Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (results.isEmpty && query.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.movie_filter_outlined,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'No movies found for "$query"',
                style: AppTextStyles.font14GreyRegular,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${results.length} results found',
            style: AppTextStyles.font14GreyRegular,
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final movie = results[index];
              final heroTag = '${movie.id}_search';
              return MovieCard(
                movie: movie,
                heroTag: heroTag,
                onTap: () {
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
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
