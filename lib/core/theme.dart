import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =================================================================================
// KELAS WARNA APLIKASI
// =================================================================================
class AppColors {
  AppColors._();

  // --- Primary Colors (Biru) ---
  static const Color primary50 = Color(0xFFE8F3FF);
  static const Color primary100 = Color(0xFFB9D9FE);
  static const Color primary200 = Color(0xFF97C6FD);
  static const Color primary300 = Color(0xFF68ADFC);
  static const Color primary400 = Color(0xFF4A9DFC);
  static const Color primary500 = Color(0xFF1D84FB);
  static const Color primary600 = Color(0xFF1A78E4);
  static const Color primary700 = Color(0xFF155EB2);
  static const Color primary800 = Color(0xFF10498A);
  static const Color primary900 = Color(0xFF0C3769);

  // --- Secondary Colors (Hijau) ---
  static const Color secondary50 = Color(0xFFEEFCF7);
  static const Color secondary100 = Color(0xFFCBF5E5);
  static const Color secondary200 = Color(0xFFB2F1D8);
  static const Color secondary300 = Color(0xFF8FEAC6);
  static const Color secondary400 = Color(0xFF79E6BB);
  static const Color secondary500 = Color(0xFF58E0AA);
  static const Color secondary600 = Color(0xFF50CC9B);
  static const Color secondary700 = Color(0xFF3E9F79);
  static const Color secondary800 = Color(0xFF307B5E);
  static const Color secondary900 = Color(0xFF255E47);

  // --- Grayscale Colors (Abu-abu) ---
  static const Color grayscale50 = Color(0xFFEBEBEB);
  static const Color grayscale100 = Color(0xFFC0C1C2);
  static const Color grayscale200 = Color(0xFFA2A3A4);
  static const Color grayscale300 = Color(0xFF787A7A);
  static const Color grayscale400 = Color(0xFF5D6061);
  static const Color grayscale500 = Color(0xFF353839);
}

class AppGradients {
  AppGradients._();

  /// Gradien utama yang digunakan untuk ikon aktif dan elemen penting lainnya.
  static const LinearGradient mainGradient = LinearGradient(
    colors: [
      AppColors.secondary500, // Opacity dihapus untuk ikon yang solid
      AppColors.secondary300,
      AppColors.primary300,
      AppColors.primary500,
    ],
    stops: [0.0, 0.38, 0.72, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// =================================================================================
// KELAS TIPOGRAFI APLIKASI
// =================================================================================
class AppTypography {
  AppTypography._();

  static final TextStyle h1 = GoogleFonts.poppins(fontSize: 37, height: 1.4);
  static final TextStyle h2 = GoogleFonts.poppins(fontSize: 32, height: 1.4);
  static final TextStyle h3 = GoogleFonts.poppins(fontSize: 28, height: 1.4);
  static final TextStyle h4 = GoogleFonts.poppins(fontSize: 24, height: 1.4);
  static final TextStyle h5 = GoogleFonts.poppins(fontSize: 21, height: 1.4);
  static final TextStyle title1 = GoogleFonts.poppins(fontSize: 18, height: 1.4);
  static final TextStyle title2 = GoogleFonts.poppins(fontSize: 16, height: 1.4);
  static final TextStyle body = GoogleFonts.poppins(fontSize: 14, height: 1.4);
  static final TextStyle caption = GoogleFonts.poppins(fontSize: 12, height: 1.4);

  // Variasi Ketebalan Font
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

// =================================================================================
// KELAS TEMA APLIKASI
// =================================================================================
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.primary500,
      fontFamily: GoogleFonts.poppins().fontFamily,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary500,
        secondary: AppColors.secondary500,
        error: Colors.redAccent,
        background: Colors.white,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: AppColors.grayscale500,
        onSurface: AppColors.grayscale500,
      ),

      textTheme: TextTheme(
        displayLarge: AppTypography.h1.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        displayMedium: AppTypography.h2.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        displaySmall: AppTypography.h3.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        headlineMedium: AppTypography.h4.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        headlineSmall: AppTypography.h5.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        titleLarge: AppTypography.title1.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        titleMedium: AppTypography.title2.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        bodyLarge: AppTypography.body.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        bodyMedium: AppTypography.body.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale500),
        bodySmall: AppTypography.caption.copyWith(fontWeight: AppTypography.regular, color: AppColors.grayscale400),
        labelLarge: AppTypography.title2.copyWith(fontWeight: AppTypography.bold, color: Colors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          textStyle: AppTypography.title2.copyWith(fontWeight: AppTypography.bold),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grayscale50,
        hintStyle: AppTypography.body.copyWith(color: AppColors.grayscale200),
        prefixIconColor: AppColors.grayscale200,
        suffixIconColor: AppColors.grayscale200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary300, width: 1.5),
        ),
      ),

      // --- PERUBAHAN DI SINI ---
      // Menggunakan CardThemeData, bukan CardTheme
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: AppColors.grayscale500.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}