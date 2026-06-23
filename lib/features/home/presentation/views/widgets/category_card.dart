import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryCard extends StatefulWidget {
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
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
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
                    color: Skeletonizer.of(context).enabled
                        ? Colors.grey[900]
                        : null,
                    gradient: Skeletonizer.of(context).enabled
                        ? null
                        : widget.gradient,
                    boxShadow: Skeletonizer.of(context).enabled
                        ? null
                        : [
                            BoxShadow(
                              color: (widget.gradient as LinearGradient)
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
                left: widget.imageOnRight ? null : -35,
                right: widget.imageOnRight ? -20 : null,
                top: widget.imageOnRight ? 20 : 30,
                child: Skeleton.ignore(
                  child: widget.imageUrl.startsWith('http')
                      ? Image.network(
                          widget.imageUrl,
                          height: widget.imageOnRight ? 155 : 145,
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(),
                        )
                      : Image.asset(
                          widget.imageUrl,
                          height: widget.imageOnRight ? 155 : 145,
                          fit: BoxFit.fitHeight,
                        ),
                ),
              ),
              Positioned(
                top: 50,
                left: widget.imageOnRight ? 20 : null,
                right: widget.imageOnRight ? null : 15,
                child: Column(
                  crossAxisAlignment: widget.imageOnRight
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.font20WhiteBold,
                    ),
                    Text(
                      widget.subtitle,
                      style: AppTextStyles.font13GreyRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
