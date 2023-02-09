import 'package:flutter/material.dart';

class AppStyles {
  static const fontFamily = '';

  static TextTheme textThemeWithColor(Color color) {
    return TextTheme(
      displaySmall: displaySmall.apply(color: color),
      displayMedium: displayMedium.apply(color: color),
      displayLarge: displayLarge.apply(color: color),
      bodySmall: bodySmall.apply(color: color),
      bodyMedium: bodyMedium.apply(color: color),
      bodyLarge: bodyLarge.apply(color: color),
      titleSmall: titleSmall.apply(color: color),
      titleMedium: titleMedium.apply(color: color),
      titleLarge: titleLarge.apply(color: color),
      headlineSmall: headlineSmall.apply(color: color),
      headlineMedium: headlineMedium.apply(color: color),
      headlineLarge: headlineLarge.apply(color: color),
    );
  }

  static const displaySmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w400);
  static const displayMedium = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const displayLarge = TextStyle(fontSize: 13, fontWeight: FontWeight.w600);

  static const bodySmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const bodyMedium = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  static const bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const titleSmall = TextStyle(fontSize: 17, fontWeight: FontWeight.w400);
  static const titleMedium = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const titleLarge = TextStyle(fontSize: 19, fontWeight: FontWeight.w700);

  static const headlineSmall = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  static const headlineMedium = TextStyle(fontSize: 21, fontWeight: FontWeight.w600);
  static const headlineLarge = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
}
