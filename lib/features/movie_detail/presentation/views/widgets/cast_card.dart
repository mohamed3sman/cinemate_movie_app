import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';

class CastCard extends StatefulWidget {
  final String name;
  final String role;
  final String imageUrl;
  final VoidCallback? onTap;
  final String? heroTag;

  const CastCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    this.onTap,
    this.heroTag,
  });

  @override
  State<CastCard> createState() => _CastCardState();
}

class _CastCardState extends State<CastCard>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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
          height: 68,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Background capsule
              Positioned(
                left: 28,
                right: 0,
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.only(left: 45, right: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(color: Color(0xff5E5E5E), blurRadius: 3)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: AppTextStyles.font15WhiteBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 1),
                      Text(
                        'As ${widget.role}',
                        style: AppTextStyles.font14GreyRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              // Avatar with gradient border
              Container(
                width: 55,
                height: 55,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF15141F),
                  ),
                  child: Hero(
                    tag: widget.heroTag ?? widget.name,
                    child: ClipOval(
                      child: widget.imageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: widget.imageUrl.startsWith('http')
                                  ? widget.imageUrl
                                  : '${ApiConstants.imageBaseUrl}${widget.imageUrl}',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.person, color: Colors.white),
                            )
                          : const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
