import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientBorderContainer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor == Colors.transparent
                ? AppColors.background
                : backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius - borderWidth),
          ),
          child: child,
        ),
      ),
    );
  }
}
