import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Gradient gradient;
  final bool imageOnRight;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.gradient,
    this.imageOnRight = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 160,
        child: Stack(
          clipBehavior: Skeletonizer.of(context).enabled
              ? Clip.hardEdge
              : Clip.none,
          children: [
            Positioned.fill(
              top: 35,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Skeletonizer.of(context).enabled ? Colors.grey[800] : null,
                  gradient: Skeletonizer.of(context).enabled ? null : gradient,
                  boxShadow: Skeletonizer.of(context).enabled
                      ? null
                      : [
                          BoxShadow(
                            color: (gradient as LinearGradient)
                                .colors
                                .first
                                .withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                ),
              ),
            ),
            Positioned(
              left: imageOnRight ? null : -35,
              right: imageOnRight ? -20 : null,
              top: imageOnRight ? 20 : 30,
              child: Skeleton.ignore(
                child: imageUrl.startsWith('http')
                    ? Image.network(
                        imageUrl,
                        height: imageOnRight ? 155 : 145,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                      )
                    : Image.asset(
                        imageUrl,
                        height: imageOnRight ? 155 : 145,
                        fit: BoxFit.fitHeight,
                      ),
              ),
            ),
            Positioned(
              top: 50,
              left: imageOnRight ? 20 : null,
              right: imageOnRight ? null : 15,
              child: Column(
                crossAxisAlignment: imageOnRight
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(title, style: AppTextStyles.font20WhiteBold),
                  Text(subtitle, style: AppTextStyles.font13GreyRegular),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
