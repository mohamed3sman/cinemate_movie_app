import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/animations/fade_in_slide.dart';

import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/core/widgets/custom_snackbar.dart';
import 'package:movie_app/features/home/presentation/views/widgets/movie_horizontal_section.dart';
import 'package:movie_app/features/person_detail/presentation/blocs/person_detail_cubit.dart';
import 'package:movie_app/features/person_detail/presentation/blocs/person_detail_state.dart';
import 'package:movie_app/injection_container.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/movie_detail_app_bar.dart';
import 'widgets/person_detail_skeleton.dart';

class PersonDetailView extends StatelessWidget {
  final int personId;
  final String imageUrl;
  final String heroTag;
  final String name;

  const PersonDetailView({
    super.key,
    required this.personId,
    required this.imageUrl,
    required this.heroTag,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PersonDetailCubit>()..loadPersonDetail(personId),
      child: BlocListener<PersonDetailCubit, PersonDetailState>(
        listener: (context, state) {
          if (state is PersonDetailError) {
            CustomSnackBar.show(context, message: state.message, isError: true);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: BlocBuilder<PersonDetailCubit, PersonDetailState>(
            builder: (context, state) {
              final isLoaded = state is PersonDetailLoaded;
              final person = isLoaded ? state.personDetail : null;

              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  MovieDetailAppBar(
                    title: person?.name ?? name,
                    imagePath: imageUrl,
                    heroTag: heroTag,
                  ),
                  SliverToBoxAdapter(
                    child: Skeletonizer(
                      enabled: !isLoaded,
                      effect: ShimmerEffect(
                        baseColor: Colors.grey[900]!,
                        highlightColor: Colors.grey[800]!,
                      ),
                      child: isLoaded
                          ? _buildContent(context, state.personDetail)
                          : const PersonDetailSkeleton(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic person) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        FadeInSlide(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                _buildInfoItem('Department', person.knownForDepartment),
                const SizedBox(width: 24),
                _buildInfoItem('Birthday', person.birthday),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInSlide(
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildInfoItem('Place of Birth', person.placeOfBirth),
          ),
        ),
        const SizedBox(height: 32),
        FadeInSlide(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Biography', style: AppTextStyles.font20WhiteBold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  person.biography.isNotEmpty
                      ? person.biography
                      : 'No biography available.',
                  style: AppTextStyles.font13GreyRegular.copyWith(height: 1.6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        if (person.knownForMovies.isNotEmpty)
          FadeInSlide(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 600),
            child: MovieHorizontalSection(
              title: 'Known For',
              movies: person.knownForMovies,
            ),
          ),
        SizedBox(height: MediaQuery.paddingOf(context).bottom + 40),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font12GreyRegular),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.font15WhiteBold),
      ],
    );
  }
}
