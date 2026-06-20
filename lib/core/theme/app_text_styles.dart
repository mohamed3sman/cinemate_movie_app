import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/size_config.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle font24WhiteBold = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(24),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle font20WhiteBold = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(20),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle font18WhiteSemiBold = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(18),
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Body
  static TextStyle font16WhiteRegular = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(16),
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static TextStyle font14GreyRegular = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(14),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle font13GreyRegular = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(13),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle font12GreyRegular = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(12),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle font15WhiteBold = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(15),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Custom styles for specific UI elements
  static TextStyle font32WhiteBold = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(32),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle font18GreyRegular = GoogleFonts.roboto(
    fontSize: getResponsiveFontSize(18),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
