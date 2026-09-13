import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tokens.dart';

/// ثيم ورديلڤا. الخط العربي: تجوال. اللاتيني للعرض: كورمورانت جارامون.
ThemeData buildWardelvaTheme() {
  final base = ThemeData.light(useMaterial3: true);
  final text = GoogleFonts.tajawalTextTheme(base.textTheme)
      .apply(bodyColor: WColors.ink, displayColor: WColors.ink);

  return base.copyWith(
    scaffoldBackgroundColor: WColors.paper,
    colorScheme: base.colorScheme.copyWith(
      primary: WColors.green,
      onPrimary: WColors.cream,
      secondary: WColors.gold,
      surface: WColors.paper,
      error: const Color(0xFF93392F),
    ),
    textTheme: text.copyWith(
      titleLarge: text.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
      bodyMedium: text.bodyMedium?.copyWith(fontSize: 13.5, height: 1.6),
      bodySmall: text.bodySmall?.copyWith(fontSize: 12, color: WColors.gray, height: 1.55),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: WColors.paper,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: WColors.green),
      titleTextStyle: text.titleMedium?.copyWith(color: WColors.ink, fontWeight: FontWeight.w700),
    ),
    dividerColor: WColors.line,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: WColors.green,
        foregroundColor: WColors.cream,
        minimumSize: const Size.fromHeight(50),
        textStyle: text.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(WRadii.button)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: WColors.green,
        minimumSize: const Size.fromHeight(50),
        side: const BorderSide(color: WColors.green100),
        textStyle: text.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(WRadii.button)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: WColors.green)),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      hintStyle: const TextStyle(color: WColors.gray, fontSize: 13),
      labelStyle: const TextStyle(color: WColors.gray, fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(WRadii.field),
        borderSide: const BorderSide(color: WColors.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(WRadii.field),
        borderSide: const BorderSide(color: WColors.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(WRadii.field),
        borderSide: const BorderSide(color: WColors.green300, width: 1.4),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: WColors.green,
      unselectedItemColor: WColors.gray,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(fontSize: 10.5),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: WColors.ink,
      contentTextStyle: const TextStyle(color: WColors.cream, fontSize: 13),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(WRadii.button)),
    ),
  );
}

/// خط العرض اللاتيني المستخدم مع اسم البراند.
TextStyle displayLatin({double size = 22, Color color = WColors.ink}) => GoogleFonts.cormorantGaramond(
      fontSize: size,
      color: color,
      letterSpacing: 3,
      fontWeight: FontWeight.w400,
    );
