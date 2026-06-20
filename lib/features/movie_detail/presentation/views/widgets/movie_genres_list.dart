import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';

class MovieGenresList extends StatelessWidget {
  final List<String> genres;

  const MovieGenresList({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              genres[index],
              style: AppTextStyles.font12GreyRegular.copyWith(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
