import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';

class MovieInfoSection extends StatelessWidget {
  final String title;
  final String tagline;
  final String studio;
  final double voteAverage;

  const MovieInfoSection({
    super.key,
    required this.title,
    required this.tagline,
    required this.studio,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font20WhiteBold,
                ),
                const SizedBox(height: 4),
                if (tagline.isNotEmpty)
                  Text(
                    tagline,
                    style: AppTextStyles.font12GreyRegular.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.white60,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(studio, style: AppTextStyles.font12GreyRegular),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    voteAverage.toStringAsFixed(1),
                    style: AppTextStyles.font15WhiteBold,
                  ),
                ],
              ),
              Text(
                'Rating',
                style: AppTextStyles.font12GreyRegular.copyWith(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
