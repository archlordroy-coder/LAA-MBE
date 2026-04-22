import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cultural Colors (Bamiléké/Bamoun inspiration - Ndop)
  static const Color indigoNdop = Color(0xFF1A237E); // Deep Indigo
  static const Color whiteNdop = Color(0xFFFFFFFF); // Pure White
  static const Color redCola = Color(0xFFB71C1C);  // Earth/Cola Red for accents
  static const Color backgroundLight = Color(0xFFF5F5F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: indigoNdop,
      primary: indigoNdop,
      secondary: redCola,
      surface: surfaceLight,
      background: backgroundLight,
      onPrimary: whiteNdop,
    ),
    textTheme: GoogleFonts.manropeTextTheme().copyWith(
      displaySmall: GoogleFonts.manrope(fontWeight: FontWeight.bold, color: indigoNdop),
      bodyMedium: GoogleFonts.inter(fontSize: 14),
      bodyLarge: GoogleFonts.inter(fontSize: 16),
    ),
    navigationRailTheme: const NavigationRailThemeData(
      backgroundColor: indigoNdop,
      selectedIconTheme: IconThemeData(color: whiteNdop),
      unselectedIconTheme: IconThemeData(color: Colors.white70),
      indicatorColor: Colors.white24,
    ),
    cardTheme: CardThemeData(
      color: whiteNdop,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: indigoNdop.withOpacity(0.1)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: indigoNdop,
      primary: Color(0xFF7986CB), // Lighter indigo for dark mode
      secondary: Color(0xFFE57373),
      surface: surfaceDark,
      background: backgroundDark,
    ),
    textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
  );
}
