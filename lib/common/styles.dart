import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static TextTheme myTextTheme = TextTheme(
    displayLarge: GoogleFonts.staatliches(
      fontSize: 42,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.staatliches(
      fontSize: 36,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displaySmall: GoogleFonts.staatliches(
      fontSize: 46,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headlineSmall: GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.questrial(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.questrial(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.questrial(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.questrial(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    labelLarge: GoogleFonts.questrial(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    bodySmall: GoogleFonts.questrial(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
    ),
    labelSmall: GoogleFonts.questrial(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );

  static ColorScheme myColorScheme = const ColorScheme.light(
    primary: Color(0xff2B3C50),
    onPrimary: Color(0xffF9FAFA),
    secondary: Color(0xff2E3F4F),
    onSecondary: Color(0xffffffff),
    surface: Color(0xFFede8e8),
    onSurface: Colors.black87,
    background: Color(0xff7D8792),
    onBackground: Color(0xffffffff),
    error: Color(0xffDFE2E5),
  );
}
