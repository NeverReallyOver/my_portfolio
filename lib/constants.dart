import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Modern gradient colors for Flutter developer portfolio
  static const Color primary = Color(0xFF0A0E27); // Deep Space Blue
  static const Color secondary = Color(0xFF1A1F3A); // Dark Purple Blue
  static const Color accent = Color(0xFF00D9FF); // Cyan (Flutter Blue)
  static const Color accentPink = Color(0xFFFF2D55); // Flutter Pink
  static const Color accentPurple = Color(0xFF9D4EDD); // Purple accent
  static const Color cardBg = Color(0xFF1E2139); // Card background
  static const Color textPrimary = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0xFFB4B8D3); // Light Gray
  static const Color gradientStart = Color(0xFF5B247A); // Purple
  static const Color gradientEnd = Color(0xFF1BCEDF); // Cyan
}

class AppTextStyles {
  static TextStyle get header => GoogleFonts.poppins(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -1,
      );

  static TextStyle get heroTitle => GoogleFonts.poppins(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -2,
      );

  static TextStyle get subHeader => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionTitle => GoogleFonts.poppins(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -1,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 18,
        color: AppColors.textSecondary,
        height: 1.7,
      );

  static TextStyle get accent => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        color: AppColors.accent,
        letterSpacing: 1,
      );

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );
}

class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
}
