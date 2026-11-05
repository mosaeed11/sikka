import 'package:flutter/material.dart';

/// Design tokens for Sikka based on Figma design system.
abstract class AppColors {
  // Brand Colors
  static const Color brandIndigo = Color(0xFF4F46E5);
  static const Color brandIndigoDark = Color(0xFF3730A3);
  static const Color brandIndigoLight = Color(0xFF818CF8);
  static const Color brandViolet = Color(0xFF7C3AED);
  static const Color brandVioletSoft = Color(0xFFE2DFFF);
  static const Color brandIndigoDeep = Color(0xFF3525CD);

  // Accents
  static const Color accentYellow = Color(0xFFFACC15);
  static const Color accentYellowLight = Color(0xFFFFE083);
  static const Color accentYellowDark = Color(0xFF231B00);

  // Neutral & Night
  static const Color nightPrimary = Color(0xFF111827);
  static const Color nightAlternative = Color(0xFF141B2B);
  static const Color splashDark = Color(0xFF293040);

  // Surfaces & Backgrounds
  static const Color surfaceDefault = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF8FAFC);
  static const Color surfaceMuted = Color(0xFFF1F3FF);
  static const Color surfaceIndigoTint = Color(0xFFE1E8FD);
  static const Color surfaceIndigoTintLight = Color(0xFFE9EDFF);
  static const Color surfaceDotInactive = Color(0xFFDCE2F7);

  // Text Colors
  static const Color textPrimary = Color(0xFF141B2B);
  static const Color textSecondary = Color(0xFF464555);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color textPlaceholder = Color(0xFF777587);
  static const Color textOnDark = Color(0xFFE1E8FD);

  // Borders & Dividers
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFD1D5DB);

  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}

abstract class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double full = 9999.0;

  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusFull = BorderRadius.all(Radius.circular(full));
}

abstract class AppSpacing {
  static const double s4 = 4.0;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s32 = 32.0;
  static const double s40 = 40.0;
  static const double s48 = 48.0;
  static const double s64 = 64.0;
}

abstract class AppTextStyles {
  static const TextStyle display = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.7,
    height: 1.3,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.55,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
    height: 1.45,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    height: 1.35,
  );

  static const TextStyle micro = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.textMuted,
    height: 1.3,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.brandIndigo,
      scaffoldBackgroundColor: AppColors.surfaceDefault,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandIndigo,
        primary: AppColors.brandIndigo,
        secondary: AppColors.brandViolet,
        surface: AppColors.surfaceDefault,
        error: AppColors.error,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: AppTextStyles.h3,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surfaceDefault,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.brandIndigo,
      scaffoldBackgroundColor: AppColors.nightPrimary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandIndigo,
        primary: AppColors.brandIndigo,
        secondary: AppColors.brandViolet,
        surface: AppColors.nightAlternative,
        error: AppColors.error,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
