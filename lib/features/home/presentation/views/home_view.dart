import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/features/home/presentation/blocs/home_cubit.dart';
import 'package:movie_app/features/home/presentation/blocs/home_state.dart';
import 'package:movie_app/features/home/presentation/views/widgets/home_header_categories_section.dart';
import 'package:movie_app/features/home/presentation/views/widgets/movie_horizontal_section.dart';
import 'package:movie_app/features/home/presentation/views/widgets/search_results_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/core/widgets/app_search_bar.dart';
import 'package:movie_app/core/widgets/custom_snackbar.dart';
import 'package:movie_app/injection_container.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadMovies(),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            CustomSnackBar.show(context, message: state.message, isError: true);
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final isSearchActive =
                      state is HomeLoaded && state.searchQuery.isNotEmpty;

                  return Skeletonizer(
                    enabled: state is HomeLoading,
                    effect: ShimmerEffect(
                      baseColor: Colors.grey[900]!,
                      highlightColor: Colors.grey[800]!,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: AppSearchBar(
                              hintText: 'Search for a movie...',
                              onChanged: (query) {
                                context.read<HomeCubit>().searchMovies(query);
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                          if (isSearchActive) ...[
                            SearchResultsGrid(
                              results: state.searchResults,
                              isSearching: state.isSearching,
                              query: state.searchQuery,
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Text(
                                'Categories',
                                style: AppTextStyles.font18WhiteSemiBold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            HomeHeaderCategoriesSection(),
                            const SizedBox(height: 50),
                            Builder(
                              builder: (context) {
                                final popularMovies = state is HomeLoaded
                                    ? state.popularMovies
                                    : <Movie>[];
                                final topRatedMovies = state is HomeLoaded
                                    ? state.topRatedMovies
                                    : <Movie>[];
                                final trendingMovies = state is HomeLoaded
                                    ? state.trendingMovies
                                    : <Movie>[];

                                return Column(
                                  children: [
                                    MovieHorizontalSection(
                                      title: 'Most Popular',
                                      movies: popularMovies,
                                      isLoading: state is HomeLoading,
                                    ),
                                    const SizedBox(height: 32),
                                    MovieHorizontalSection(
                                      title: 'Most Rated',
                                      movies: topRatedMovies,
                                      isLoading: state is HomeLoading,
                                    ),
                                    const SizedBox(height: 32),
                                    MovieHorizontalSection(
                                      title: 'Trending',
                                      movies: trendingMovies,
                                      isLoading: state is HomeLoading,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
