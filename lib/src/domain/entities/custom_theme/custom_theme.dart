import 'dart:convert';

import 'package:flutter/painting.dart';

import 'package:innoscripta_test_task/src/core/constants/constants.dart';

class CustomTheme {
  final Color primaryColor;
  final Color activeColor;
  final Color secondaryColor;

  const CustomTheme({
    required this.primaryColor,
    required this.activeColor,
    required this.secondaryColor,
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
  );

  static const superTheme = CustomTheme(
    primaryColor: AppColors.greyLight,
    activeColor: AppColors.orangeLight,
    secondaryColor: AppColors.purpleDark,
  );

  static const awesomeTheme = CustomTheme(
    primaryColor: AppColors.greenLight,
    activeColor: AppColors.blueDark,
    secondaryColor: AppColors.greyDark,
  );

  CustomTheme copyWith({
    Color? primaryColor,
    Color? activeColor,
    Color? secondaryColor,
  }) {
    return CustomTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      activeColor: activeColor ?? this.activeColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  String toString() => 'CustomTheme(primaryColor: $primaryColor, activeColor: $activeColor, secondaryColor: $secondaryColor)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'primaryColor': primaryColor.value});
    result.addAll({'activeColor': activeColor.value});
    result.addAll({'secondaryColor': secondaryColor.value});

    return result;
  }

  factory CustomTheme.fromMap(Map<String, dynamic> map) {
    return CustomTheme(
      primaryColor: Color(map['primaryColor']),
      activeColor: Color(map['activeColor']),
      secondaryColor: Color(map['secondaryColor']),
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
        other.secondaryColor == secondaryColor;
  }

  @override
  int get hashCode => primaryColor.hashCode ^ activeColor.hashCode ^ secondaryColor.hashCode;
}
