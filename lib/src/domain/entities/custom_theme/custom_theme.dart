import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';

class CustomTheme {
  final Color primaryColor;
  final Color activeColor;
  final Color secondaryColor;
  final ThemeMode themeMode;

  const CustomTheme({
    required this.primaryColor,
    required this.activeColor,
    required this.secondaryColor,
    this.themeMode = ThemeMode.system,
  });

  static const appThemes = [
    defaultTheme,
    superTheme,
    awesomeTheme,
  ];

  static const defaultTheme = CustomTheme(
    primaryColor: AppColors.greyDark,
    activeColor: AppColors.orangeDark,
    secondaryColor: AppColors.greyLight,
    themeMode: ThemeMode.dark,
  );

  static const superTheme = CustomTheme(
    primaryColor: AppColors.greyLight,
    activeColor: AppColors.orangeLight,
    secondaryColor: AppColors.purpleDark,
    themeMode: ThemeMode.light,
  );

  static const awesomeTheme = CustomTheme(
    primaryColor: AppColors.greenLight,
    activeColor: AppColors.blueDark,
    secondaryColor: AppColors.greyDark,
    themeMode: ThemeMode.light,
  );

  CustomTheme copyWith({
    Color? primaryColor,
    Color? activeColor,
    Color? secondaryColor,
    ThemeMode? themeMode,
  }) {
    return CustomTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      activeColor: activeColor ?? this.activeColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  String toString() {
    return 'CustomTheme(primaryColor: $primaryColor, activeColor: $activeColor, secondaryColor: $secondaryColor, themeMode: $themeMode)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'primaryColor': primaryColor.value});
    result.addAll({'activeColor': activeColor.value});
    result.addAll({'secondaryColor': secondaryColor.value});
    result.addAll({'themeMode': themeMode.name});

    return result;
  }

  factory CustomTheme.fromMap(Map<String, dynamic> map) {
    return CustomTheme(
      primaryColor: Color(map['primaryColor']),
      activeColor: Color(map['activeColor']),
      secondaryColor: Color(map['secondaryColor']),
      themeMode: Utils.parseThemeMode(map['themeMode']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomTheme.fromJson(String source) => CustomTheme.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomTheme &&
        other.primaryColor == primaryColor &&
        other.activeColor == activeColor &&
        other.secondaryColor == secondaryColor &&
        other.themeMode == themeMode;
  }

  @override
  int get hashCode {
    return primaryColor.hashCode ^ activeColor.hashCode ^ secondaryColor.hashCode ^ themeMode.hashCode;
  }
}
