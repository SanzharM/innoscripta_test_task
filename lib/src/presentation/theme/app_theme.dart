import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innoscripta_test_task/src/core/constants/app_colors.dart';
import 'package:innoscripta_test_task/src/core/constants/app_styles.dart';
import 'package:innoscripta_test_task/src/domain/entities/custom_theme/custom_theme.dart';

class AppTheme {
  AppTheme();

  static ThemeData custom(CustomTheme theme) {
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.secondaryColor;
    final actionColor = theme.activeColor;
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: secondaryColor,
        elevation: 0,
        foregroundColor: primaryColor,
      ),
      textTheme: AppStyles.textThemeWithColor(primaryColor),
      iconTheme: IconThemeData(
        color: actionColor,
      ),
      indicatorColor: primaryColor,
      highlightColor: actionColor,
      hintColor: primaryColor.withOpacity(0.6),
      dividerColor: primaryColor.withOpacity(0.2),
      colorScheme: ColorScheme.light(
        onError: AppColors.red,
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        primaryColor: actionColor,
        scaffoldBackgroundColor: secondaryColor,
        barBackgroundColor: AppColors.transparent,
        textTheme: CupertinoTextThemeData(
          primaryColor: actionColor,
          actionTextStyle: AppStyles.bodyLarge.copyWith(
            color: actionColor,
          ),
          textStyle: AppStyles.bodyMedium,
        ),
      ),
    );
  }

  static ThemeData get light {
    const primaryColor = AppColors.greyDark;
    const secondaryColor = AppColors.greyLight;
    const actionColor = AppColors.orangeDark;
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: secondaryColor,
        elevation: 0,
        foregroundColor: primaryColor,
      ),
      textTheme: AppStyles.textThemeWithColor(AppColors.black),
      iconTheme: const IconThemeData(
        color: actionColor,
      ),
      indicatorColor: primaryColor,
      highlightColor: actionColor,
      hintColor: primaryColor.withOpacity(0.6),
      dividerColor: primaryColor.withOpacity(0.2),
      colorScheme: const ColorScheme.light(
        onError: AppColors.red,
      ),
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        primaryColor: actionColor,
        scaffoldBackgroundColor: secondaryColor,
        barBackgroundColor: AppColors.transparent,
        textTheme: CupertinoTextThemeData(
          primaryColor: actionColor,
          actionTextStyle: AppStyles.bodyLarge.copyWith(
            color: actionColor,
          ),
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
      textTheme: AppStyles.textThemeWithColor(AppColors.white),
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
