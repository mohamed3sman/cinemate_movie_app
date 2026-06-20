import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.removeCurrentSnackBar();

    scaffoldMessenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        content: Container(
          padding: const EdgeInsets.all(1.5), // For gradient border effect
          decoration: BoxDecoration(
            gradient: isError
                ? const LinearGradient(colors: [Colors.redAccent, Colors.red])
                : AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(14.5),
            ),
            child: Row(
              children: [
                Icon(
                  isError ? Icons.error_outline : Icons.check_circle_outline,
                  color: isError ? Colors.redAccent : const Color(0xFF00E5FF),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isError ? 'Error' : 'Success',
                        style: AppTextStyles.font15WhiteBold.copyWith(
                          color: isError
                              ? Colors.redAccent
                              : const Color(0xFF00E5FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(message, style: AppTextStyles.font13GreyRegular),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
