import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF0A192F); // Dark Navy
  static const Color secondary = Color(0xFF112240); // Lighter Navy
  static const Color accent = Color(0xFF64FFDA); // Teal/Cyan
  static const Color textPrimary = Color(0xFFCCD6F6); // Light Gray
  static const Color textSecondary = Color(0xFF8892B0); // Slate
  static const Color white = Colors.white;
}

class AppTextStyles {
  static TextStyle get header => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        fontFamily: 'SansSerif',
      );

  static TextStyle get subHeader => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        fontFamily: 'SansSerif',
      );

  static TextStyle get body => const TextStyle(
        fontSize: 16,
        color: AppColors.textSecondary,
        height: 1.5,
        fontFamily: 'SansSerif',
      );
  
  static TextStyle get accent => const TextStyle(
        fontSize: 14,
        color: AppColors.accent,
        fontFamily: 'Monospace',
      );
}
