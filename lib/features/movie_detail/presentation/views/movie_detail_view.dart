import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/animations/fade_in_slide.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/core/widgets/gradient_border_container.dart';
import 'package:movie_app/core/widgets/custom_snackbar.dart';
import 'package:movie_app/features/movie_detail/presentation/blocs/movie_detail_cubit.dart';
import 'package:movie_app/features/movie_detail/presentation/blocs/movie_detail_state.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_detail_skeleton.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_cast_section.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_detail_app_bar.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_financials_section.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_genres_list.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_info_section.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_metadata_row.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_production_section.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_section_title.dart';
import 'package:movie_app/features/movie_detail/presentation/blocs/trailer_cubit.dart';
import 'package:movie_app/features/movie_detail/presentation/views/trailer_player_view.dart';
import 'package:movie_app/injection_container.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieDetailView extends StatelessWidget {
  final int movieId;
  final String? posterPath;
  final String? heroTag;

  const MovieDetailView({
    super.key,
    required this.movieId,
    this.posterPath,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailCubit>()..loadMovieDetail(movieId),
      child: BlocListener<MovieDetailCubit, MovieDetailState>(
        listener: (context, state) {
          if (state is MovieDetailError) {
            CustomSnackBar.show(context, message: state.message, isError: true);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailError) {
                return Center(
                  child: Text(
                    state.message,
                    style: AppTextStyles.font16WhiteRegular,
                  ),
                );
              }

              final movie = state is MovieDetailLoaded
                  ? state.movieDetail
                  : MovieDetailSkeleton(
                      movieId: movieId,
                      posterPath: posterPath,
                    );

              final imageToShow = (posterPath != null && posterPath!.isNotEmpty)
                  ? posterPath!
                  : (movie.posterPath.isNotEmpty
                        ? movie.posterPath
                        : movie.backdropPath);

              final isLoaded = state is MovieDetailLoaded;

              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<MovieDetailCubit>().loadMovieDetail(
                      movieId,
                    );
                  },
                  backgroundColor: AppColors.cardBackground,
                  color: Colors.white,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      MovieDetailAppBar(
                        title: movie.title,
                        imagePath: imageToShow,
                        heroTag: heroTag ?? movieId.toString(),
                      ),
                      SliverToBoxAdapter(
                        child: Skeletonizer(
                          enabled: state is MovieDetailLoading,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              // Info section fades in first
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 100 : 0,
                                ),
                                duration: const Duration(milliseconds: 500),
                                child: MovieInfoSection(
                                  title: movie.title,
                                  tagline: movie.tagline,
                                  studio: movie.studio,
                                  voteAverage: movie.voteAverage,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Metadata row slides in
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 200 : 0,
                                ),
                                duration: const Duration(milliseconds: 500),
                                beginOffset: const Offset(-0.15, 0),
                                child: MovieMetadataRow(
                                  releaseDate: movie.releaseDate,
                                  runtime: movie.runtime,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Genres slide in from left
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 300 : 0,
                                ),
                                duration: const Duration(milliseconds: 500),
                                beginOffset: const Offset(-0.15, 0),
                                child: MovieGenresList(genres: movie.genres),
                              ),
                              const SizedBox(height: 24),
                              // Storyline section
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 400 : 0,
                                ),
                                duration: const Duration(milliseconds: 500),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const MovieSectionTitle(title: 'Storyline'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                      ),
                                      child: Text(
                                        movie.overview,
                                        style: AppTextStyles.font13GreyRegular
                                            .copyWith(height: 1.6),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Cast section slides up
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 500 : 0,
                                ),
                                duration: const Duration(milliseconds: 600),
                                child: MovieCastSection(cast: movie.cast, movieId: movieId),
                              ),
                              const SizedBox(height: 32),
                              // Production section
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 600 : 0,
                                ),
                                duration: const Duration(milliseconds: 600),
                                child: MovieProductionSection(
                                  companies: movie.productionCompanies,
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Financials section
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 700 : 0,
                                ),
                                duration: const Duration(milliseconds: 600),
                                child: MovieFinancialsSection(
                                  budget: movie.budget,
                                  revenue: movie.revenue,
                                ),
                              ),
                              const SizedBox(height: 40),
                              // Watch button slides up last with bounce
                              FadeInSlide(
                                delay: Duration(
                                  milliseconds: isLoaded ? 800 : 0,
                                ),
                                duration: const Duration(milliseconds: 700),
                                beginOffset: const Offset(0, 0.3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: GradientBorderContainer(
                                    onTap: () {
                                      if (movie.trailerKey != null) {
                                        context
                                            .read<TrailerCubit>()
                                            .playTrailer(movie.trailerKey!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TrailerPlayerView(
                                                  videoKey: movie.trailerKey!,
                                                ),
                                          ),
                                        );
                                      } else {
                                        CustomSnackBar.show(
                                          context,
                                          message:
                                              'No trailer available for this movie',
                                          isError: true,
                                        );
                                      }
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Watch now',
                                        style: AppTextStyles.font16WhiteRegular
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.paddingOf(context).bottom + 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
