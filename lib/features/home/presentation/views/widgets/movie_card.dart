import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/core/utils/app_images.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: movie.posterPath.isEmpty
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
                      tag: heroTag ?? movie.id.toString(),
                      child: CachedNetworkImage(
                        imageUrl: movie.posterPath.startsWith('http')
                            ? movie.posterPath
                            : '${ApiConstants.imageBaseUrl}${movie.posterPath}',
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
            movie.title,
            style: AppTextStyles.font15WhiteBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            movie.releaseDate.isNotEmpty
                ? movie.releaseDate.split('-')[0]
                : '2024',
            style: AppTextStyles.font13GreyRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
