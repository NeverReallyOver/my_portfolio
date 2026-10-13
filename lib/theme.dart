import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour tokens. One accent, warm neutrals, and market green/red used only
/// inside the live watchlist.
class Palette {
  static const Color paper = Color(0xFFF6F4EF);
  static const Color paperRaised = Color(0xFFFFFFFF);
  static const Color paperSunk = Color(0xFFEDEAE3);
  static const Color ink = Color(0xFF16181D);
  static const Color inkSoft = Color(0xFF3D424C);
  static const Color muted = Color(0xFF6B717C);
  static const Color hairline = Color(0xFFDCD7CC);

  static const Color accent = Color(0xFF1F3A5F);
  static const Color accentSoft = Color(0xFFE3E9F1);

  static const Color up = Color(0xFF0E7C5B);
  static const Color upSoft = Color(0xFFDDF0E8);
  static const Color down = Color(0xFFC0392B);
  static const Color downSoft = Color(0xFFF7E1DE);
  static const Color available = Color(0xFF2E9E6B);
}

/// Type scale. Fraunces for display, IBM Plex Sans for reading, IBM Plex Mono
/// for labels and numbers.
class Fonts {
  static TextStyle display(double size) => GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 1.08,
        letterSpacing: -0.02 * size,
        color: Palette.ink,
      );

  static TextStyle title(double size) => GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: -0.01 * size,
        color: Palette.ink,
      );

  static TextStyle body(
          {double size = 16,
          Color color = Palette.inkSoft,
          FontWeight weight = FontWeight.w400}) =>
      GoogleFonts.ibmPlexSans(
          fontSize: size, height: 1.6, color: color, fontWeight: weight);

  static TextStyle label(
          {double size = 12,
          Color color = Palette.muted,
          FontWeight weight = FontWeight.w500}) =>
      GoogleFonts.ibmPlexMono(
          fontSize: size,
          height: 1.4,
          letterSpacing: 0.4,
          color: color,
          fontWeight: weight);

  static TextStyle number(double size, {Color color = Palette.ink}) =>
      GoogleFonts.ibmPlexMono(
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 1.1,
        letterSpacing: -0.02 * size,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Palette.paper,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.accent,
      primary: Palette.accent,
      surface: Palette.paper,
      onSurface: Palette.ink,
    ),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(),
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: Palette.accentSoft),
    splashFactory: NoSplash.splashFactory,
  );
}
