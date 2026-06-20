import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/size_config.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle get font24WhiteBold => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(24),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get font20WhiteBold => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(20),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get font18WhiteSemiBold => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(18),
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Body
  static TextStyle get font16WhiteRegular => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(16),
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static TextStyle get font14GreyRegular => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(14),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle get font13GreyRegular => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(13),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle get font12GreyRegular => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(12),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle get font15WhiteBold => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(15),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Custom styles for specific UI elements
  static TextStyle get font32WhiteBold => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(32),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get font18GreyRegular => GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(18),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
