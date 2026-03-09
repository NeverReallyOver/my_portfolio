import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Height of the fixed navbar (pure content height, no safe-area).
const double kNavBarHeight = 65.0;

class AppColors {
  // Deep navy + electric cyan — from janakiraman-portfolio.web.app
  static const Color bg             = Color(0xFF0A0E27); // deep navy
  static const Color surface        = Color(0xFF0D1232); // slightly lighter navy
  static const Color surfaceElevated = Color(0xFF131940); // card bg
  static const Color border         = Color(0xFF1E2A5E); // navy-tinted border
  static const Color borderMuted    = Color(0xFF141A3A);

  static const Color accent         = Color(0xFF00D9FF); // electric cyan
  static const Color accentGreen    = Color(0xFF00FF88); // bright green
  static const Color accentOrange   = Color(0xFFFF9500); // vivid orange
  static const Color accentPurple   = Color(0xFF7B61FF); // electric purple
  static const Color accentPink     = Color(0xFFFF6B9D); // pink

  static const Color textPrimary    = Color(0xFFE6F0FF);
  static const Color textSecondary  = Color(0xFF8892B0);
  static const Color textMuted      = Color(0xFF4A5A80);

  // Backward-compat aliases used throughout existing widgets
  static const Color primary        = bg;
  static const Color secondary      = surface;
  static const Color cardBg         = surfaceElevated;
  static const Color gradientStart  = accent;
  static const Color gradientEnd    = accentGreen;
}

/// Pre-built box-shadow lists for consistent depth/glow across the site.
class AppShadows {
  static List<BoxShadow> get card => [
    BoxShadow(
      color: AppColors.accent.withValues(alpha: 0.06),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get featured => [
    BoxShadow(
      color: AppColors.accent.withValues(alpha: 0.14),
      blurRadius: 32,
      offset: const Offset(0, 6),
    ),
  ];
}

class AppTextStyles {
  static TextStyle get header => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.5,
        height: 1.1,
      );

  static TextStyle get heroTitle => GoogleFonts.inter(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -2,
        height: 1.05,
      );

  static TextStyle get subHeader => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      );

  static TextStyle get sectionTitle => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.8,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 15,
        color: AppColors.textSecondary,
        height: 1.75,
      );

  static TextStyle get accent => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        color: AppColors.accent,
        letterSpacing: 0.3,
      );

  static TextStyle get button => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0,
      );
}

class AppDurations {
  static const Duration fast   = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow   = Duration(milliseconds: 400);
}
