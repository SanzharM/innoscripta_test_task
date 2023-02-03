import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innoscripta_test_task/src/core/constants/app_colors.dart';
import 'package:innoscripta_test_task/src/core/constants/app_styles.dart';

class AppTheme {
  AppTheme();

  static ThemeData get light {
    const primaryColor = AppColors.greyDark;
    const secondaryColor = AppColors.greyLight;
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: secondaryColor,
        elevation: 0,
        foregroundColor: primaryColor,
      ),
      textTheme: AppStyles.textTheme,
      iconTheme: const IconThemeData(
        color: primaryColor,
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: secondaryColor,
        barBackgroundColor: AppColors.transparent,
        textTheme: CupertinoTextThemeData(
          primaryColor: primaryColor,
          textStyle: AppStyles.bodyMedium,
        ),
      ),
    );
  }

  static ThemeData get dark {
    const primaryColor = AppColors.greyLight;
    const secondaryColor = AppColors.greyDark;
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: secondaryColor,
        elevation: 0,
        foregroundColor: primaryColor,
      ),
      textTheme: AppStyles.textTheme,
      iconTheme: const IconThemeData(
        color: primaryColor,
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: secondaryColor,
        barBackgroundColor: AppColors.transparent,
        textTheme: CupertinoTextThemeData(
          primaryColor: primaryColor,
          textStyle: AppStyles.bodyMedium,
        ),
      ),
    );
  }
}
