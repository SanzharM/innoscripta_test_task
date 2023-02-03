import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const fontFamily = '';

  static const textTheme = TextTheme(
    displaySmall: displaySmall,
    displayMedium: displayMedium,
    displayLarge: displayLarge,
    bodySmall: bodySmall,
    bodyMedium: bodyMedium,
    bodyLarge: bodyLarge,
    titleSmall: titleSmall,
    titleMedium: titleMedium,
    titleLarge: titleLarge,
    headlineSmall: headlineSmall,
    headlineMedium: headlineMedium,
    headlineLarge: headlineLarge,
  );

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
