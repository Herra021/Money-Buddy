import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary palette - Deep Trust Blue
  static const Color primary = Color(0xFF002A6D);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF0A3F97);
  static const Color onPrimaryContainer = Color(0xFF92B0FF);
  static const Color inversePrimary = Color(0xFFB1C5FF);

  // Secondary palette - Sky Blue
  static const Color secondary = Color(0xFF006686);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF2BC6FF);
  static const Color onSecondaryContainer = Color(0xFF004F69);

  // Tertiary
  static const Color tertiary = Color(0xFF243035);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF3A464B);
  static const Color onTertiaryContainer = Color(0xFFA7B4BA);

  // Surfaces
  static const Color surface = Color(0xFFFAF8FF);
  static const Color surfaceDim = Color(0xFFD7D9E8);
  static const Color surfaceBright = Color(0xFFFAF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FF);
  static const Color surfaceContainer = Color(0xFFEBEDFC);
  static const Color surfaceContainerHigh = Color(0xFFE6E7F6);
  static const Color surfaceContainerHighest = Color(0xFFE0E2F1);
  static const Color onSurface = Color(0xFF181B26);
  static const Color onSurfaceVariant = Color(0xFF434652);
  static const Color inverseSurface = Color(0xFF2D303B);
  static const Color inverseOnSurface = Color(0xFFEEF0FF);

  // Outline
  static const Color outline = Color(0xFF747783);
  static const Color outlineVariant = Color(0xFFC4C6D4);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Background
  static const Color background = Color(0xFFFAF8FF);
  static const Color onBackground = Color(0xFF181B26);
  static const Color surfaceVariant = Color(0xFFE0E2F1);

  // Semantic
  static const Color income = Color(0xFF0A6640);
  static const Color expense = Color(0xFFBA1A1A);
  static const Color lend = Color(0xFF0A3F97);
  static const Color borrow = Color(0xFF884F00);
}

class AppTheme {
  // Geist is not on Google Fonts; we use Inter as a close geometric sans substitute
  static TextStyle _geist(
      {double fontSize = 14,
      FontWeight fontWeight = FontWeight.w400,
      double height = 1.43,
      double? letterSpacing,
      Color color = AppColors.onSurface}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceContainerHighest,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        inverseSurface: AppColors.inverseSurface,
        onInverseSurface: AppColors.inverseOnSurface,
        inversePrimary: AppColors.inversePrimary,
        surfaceTint: Color(0xFF325AB3),
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: baseTextTheme.copyWith(
        displayLarge: _geist(fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -0.96, height: 1.17),
        displayMedium: _geist(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.64, height: 1.25),
        headlineLarge: _geist(fontSize: 32, fontWeight: FontWeight.w600, letterSpacing: -0.32, height: 1.25),
        headlineMedium: _geist(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.24, height: 1.33),
        headlineSmall: _geist(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4),
        titleLarge: _geist(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4),
        titleMedium: _geist(fontSize: 16, fontWeight: FontWeight.w500, height: 1.5),
        titleSmall: _geist(fontSize: 14, fontWeight: FontWeight.w500, height: 1.43),
        bodyLarge: _geist(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
        bodyMedium: _geist(fontSize: 14, fontWeight: FontWeight.w400, height: 1.43),
        bodySmall: _geist(fontSize: 12, fontWeight: FontWeight.w400, height: 1.33),
        labelLarge: _geist(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.14, height: 1.43),
        labelMedium: _geist(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.24, height: 1.33),
        labelSmall: _geist(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.22, height: 1.45),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceContainerLowest,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: AppColors.primaryContainer,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.secondaryContainer, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.onSurfaceVariant),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.outline),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          minimumSize: const Size(double.infinity, 52),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryContainer,
          side: const BorderSide(color: AppColors.primaryContainer),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          minimumSize: const Size(double.infinity, 52),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          minimumSize: const Size(double.infinity, 52),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceContainerLowest,
        selectedItemColor: AppColors.primaryContainer,
        unselectedItemColor: AppColors.outline,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceContainerHigh,
        selectedColor: AppColors.primaryContainer,
        side: const BorderSide(color: AppColors.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outlineVariant,
        thickness: 1,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryContainer,
        foregroundColor: AppColors.onPrimary,
        elevation: 4,
        shape: CircleBorder(),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.surfaceContainerLowest,
        titleTextStyle: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        contentTextStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.onSurfaceVariant, height: 1.5),
      ),
    );
  }
}
