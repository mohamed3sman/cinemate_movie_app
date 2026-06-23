import 'package:flutter/material.dart';
import 'package:movie_app/core/animations/fade_in_slide.dart';
import 'package:movie_app/core/animations/fade_slide_page_route.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/utils/app_images.dart';
import 'package:movie_app/features/category_details/presentation/views/category_details_view.dart';
import 'package:movie_app/features/home/presentation/views/widgets/category_card.dart';

class HomeHeaderCategoriesSection extends StatelessWidget {
  const HomeHeaderCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Expanded(
            child: FadeInSlide(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              beginOffset: const Offset(-0.2, 0),
              child: CategoryCard(
                title: 'Movies',
                subtitle: '',
                imageUrl: AppImages.moviesImage,
                gradient: AppColors.movieCategoryGradient,
                imageOnRight: false,
                onTap: () {
                  Navigator.push(
                    context,
                    FadeSlidePageRoute(
                      page: const CategoryDetailsView(
                        categoryName: 'Movies',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: FadeInSlide(
              delay: const Duration(milliseconds: 350),
              duration: const Duration(milliseconds: 600),
              beginOffset: const Offset(0.2, 0),
              child: CategoryCard(
                title: 'Animes',
                subtitle: '',
                imageUrl: AppImages.animesImage,
                gradient: AppColors.animeCategoryGradient,
                imageOnRight: true,
                onTap: () {
                  Navigator.push(
                    context,
                    FadeSlidePageRoute(
                      page: const CategoryDetailsView(
                        categoryName: 'Animes',
                        genreId: ApiConstants.animationGenreId,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
