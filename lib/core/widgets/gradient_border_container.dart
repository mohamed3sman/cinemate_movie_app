import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientBorderContainer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final double borderWidth;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const GradientBorderContainer({
    super.key,
    required this.child,
    this.borderRadius = 30.0,
    this.borderWidth = 1.5,
    this.gradient = AppColors.primaryGradient,
    this.padding,
    this.onTap,
    this.backgroundColor = Colors.transparent,
  });

  @override
  State<GradientBorderContainer> createState() =>
      _GradientBorderContainerState();
}

class _GradientBorderContainerState extends State<GradientBorderContainer>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Rotating gradient shimmer
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Press scale
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
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
        child: AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.all(widget.borderWidth),
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  center: Alignment.center,
                  startAngle: 0,
                  endAngle: 6.28,
                  transform: GradientRotation(
                    _shimmerController.value * 6.28,
                  ),
                  colors: const [
                    Color(0xFF00E5FF),
                    Color(0xFFD500F9),
                    Color(0xFF00E5FF),
                    Color(0xFFD500F9),
                    Color(0xFF00E5FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFF00E5FF,
                    ).withValues(alpha: 0.15),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: widget.backgroundColor == Colors.transparent
                      ? AppColors.background
                      : widget.backgroundColor,
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius - widget.borderWidth,
                  ),
                ),
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}
