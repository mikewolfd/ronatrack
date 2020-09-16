import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorUtils {
  static const Color primaryColor = Color(0xffDF392E);
  static const Color accentColor = Color(0xffFF4E00);
  static const Color orangeGradientEnd = Color(0xfffc4a1a);
  static const Color orangeGradientStart = Color(0xfff7b733);
  static const Color themeGradientStart = Color(0xFFEC692D);
  static const Color themeGradientEnd = Color(0xFFEAA23F);
  static const LinearGradient appBarGradient =
      LinearGradient(colors: [themeGradientStart, themeGradientEnd]);
}

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xFF0097A7),
  primaryColorLight: const Color(0xFFB2EBF2),
  primaryColor: const Color(0xFF00BCD4),
  accentColor: const Color(0xFF009688),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
