import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central design tokens for the app. Use these instead of ad-hoc colors.
class Brand {
  Brand._();

  // Brand colors taken from assets/greenwaylogo.png
  static const Color logoBlue = Color(0xFF0004CA);
  static const Color logoGreen = Color(0xFF34B448);
  static const Color logoLightGreen = Color(0xFF90C844);

  static const Color primary = logoBlue;
  static const Color primaryDark = Color(0xFF00029A);
  static const Color primaryLight = Color(0xFFE6E7FB);
  static const Color accent = logoGreen;
  static const Color accentLight = Color(0xFFE3F5E6);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerLight = Color(0xFFFEE2E2);

  static const Color background = Color(0xFFF4F6FB);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE3E7EF);
  static const Color text = Color(0xFF151A2D);
  static const Color textMuted = Color(0xFF6B7385);

  static const double radius = 16;
  static const double radiusSm = 10;
  static const double gutter = 16;

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xFF1A1FE0), logoBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [logoLightGreen, logoGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient amberGradient = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFEA580C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient violetGradient = LinearGradient(
    colors: [Color(0xFFA78BFA), Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: const Color(0xFF1B2559).withValues(alpha: 0.06),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ];

  static ThemeData theme() {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: accent,
      surface: surface,
      error: danger,
    );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
    );
    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme)
          .apply(bodyColor: text, displayColor: text),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(64, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusSm + 4)),
          textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          minimumSize: const Size(64, 46),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusSm)),
          textStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 46),
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusSm)),
          textStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm + 2),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm + 2),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm + 2),
          borderSide: const BorderSide(color: primary, width: 1.6),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm)),
      ),
      dividerTheme: const DividerThemeData(color: border, thickness: 1),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primaryLight,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? primary
                : textMuted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? primary
                : textMuted,
          ),
        ),
      ),
    );
  }
}
