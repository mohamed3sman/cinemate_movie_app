import 'package:flutter/material.dart';
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
            child: CategoryCard(
              title: 'Movies',
              subtitle: '',
              imageUrl: AppImages.moviesImage,
              gradient: AppColors.movieCategoryGradient,
              imageOnRight: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CategoryDetailsView(categoryName: 'Movies'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: CategoryCard(
              title: 'Animes',
              subtitle: '',
              imageUrl: AppImages.animesImage,
              gradient: AppColors.animeCategoryGradient,
              imageOnRight: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryDetailsView(
                      categoryName: 'Animes',
                      genreId: ApiConstants.animationGenreId,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
