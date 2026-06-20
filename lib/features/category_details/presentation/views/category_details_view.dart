import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/core/widgets/custom_snackbar.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/features/home/presentation/views/widgets/movie_card.dart';
import 'package:movie_app/features/movie_detail/presentation/views/movie_detail_view.dart';
import 'package:movie_app/injection_container.dart';
import '../blocs/category_cubit.dart';
import '../blocs/category_state.dart';

class CategoryDetailsView extends StatelessWidget {
  final String categoryName;
  final int? genreId;

  const CategoryDetailsView({
    super.key,
    required this.categoryName,
    this.genreId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryCubit>()..loadCategoryMovies(genreId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(categoryName, style: AppTextStyles.font18WhiteSemiBold),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocListener<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                isError: true,
              );
            }
          },
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state is CategoryLoading,
                effect: ShimmerEffect(
                  baseColor: Colors.grey[900]!,
                  highlightColor: Colors.grey[800]!,
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 210,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state is CategoryLoaded ? state.movies.length : 9,
                  itemBuilder: (context, index) {
                    final movie = state is CategoryLoaded
                        ? state.movies[index]
                        : const Movie(
                            id: 1,
                            title: 'Movie Title Loading',
                            posterPath: '',
                            backdropPath: '',
                            releaseDate: '2024',
                            overview: '',
                            voteAverage: 0.0,
                          );
                    final heroTag = '${movie.id}_$categoryName';
                    return MovieCard(
                      movie: movie,
                      heroTag: heroTag,
                      onTap: () {
                        if (state is CategoryLoaded) {
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
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
