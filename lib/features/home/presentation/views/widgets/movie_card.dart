import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/core/utils/app_images.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final VoidCallback onTap;
  final String? heroTag;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    this.heroTag,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard>
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
        widget.onTap();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          children: [
            Expanded(
              child: widget.movie.posterPath.isEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        AppImages.noPosterImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Skeleton.ignore(
                      child: Hero(
                        tag: widget.heroTag ?? widget.movie.id.toString(),
                        child: CachedNetworkImage(
                          imageUrl: widget.movie.posterPath.startsWith('http')
                              ? widget.movie.posterPath
                              : '${ApiConstants.imageBaseUrl}${widget.movie.posterPath}',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              AppImages.noPosterImage,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.movie.title,
              style: AppTextStyles.font15WhiteBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              widget.movie.releaseDate.isNotEmpty
                  ? widget.movie.releaseDate.split('-')[0]
                  : '2024',
              style: AppTextStyles.font13GreyRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
