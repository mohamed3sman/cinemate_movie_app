import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF15141F);
  static const Color primary = Color(0xFF00E5FF);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFBCBCBC);
  static const Color cardBackground = Color(0xFF211F30);

  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFFD500F9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient movieCategoryGradient = LinearGradient(
    colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient animeCategoryGradient = LinearGradient(
    colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
