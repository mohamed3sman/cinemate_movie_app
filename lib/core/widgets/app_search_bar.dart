import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const AppSearchBar({super.key, required this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(1.5), // Border width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors.primaryGradient,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18.5),
        ),
        child: TextField(
          onChanged: onChanged,
          style: AppTextStyles.font16WhiteRegular,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.font14GreyRegular,
            border: InputBorder.none,
            icon: const Icon(Icons.search, color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}
