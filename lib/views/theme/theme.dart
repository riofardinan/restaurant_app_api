import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFFFFDF00);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.robotoSlab(
      fontSize: 82, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.robotoSlab(
      fontSize: 51, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.robotoSlab(fontSize: 41, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.robotoSlab(
      fontSize: 29, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.robotoSlab(fontSize: 20, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.robotoSlab(
      fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.robotoSlab(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.robotoSlab(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.roboto(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
