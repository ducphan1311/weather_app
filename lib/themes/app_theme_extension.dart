import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color errorBackgroundColor;
  final Color errorButtonColor;
  final Color temperatureColor;
  final Color locationColor;
  final Color forecastTextColor;

  const AppThemeExtension({
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.backgroundColor,
    required this.errorBackgroundColor,
    required this.errorButtonColor,
    required this.temperatureColor,
    required this.locationColor,
    required this.forecastTextColor,
  });

  static const light = AppThemeExtension(
    primaryTextColor: Color(0xFF2A2A2A),
    secondaryTextColor: Color(0xFF2A2A2A),
    backgroundColor: Color(0xFFF5F6F7),
    errorBackgroundColor: Color(0xFFE85959),
    errorButtonColor: Color(0xFF4A4A4A),
    temperatureColor: Color(0xFF2A2A2A),
    locationColor: Color(0xFF556799),
    forecastTextColor: Color(0xFF2A2A2A),
  );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? backgroundColor,
    Color? errorBackgroundColor,
    Color? errorButtonColor,
    Color? temperatureColor,
    Color? locationColor,
    Color? forecastTextColor,
  }) {
    return AppThemeExtension(
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      errorButtonColor: errorButtonColor ?? this.errorButtonColor,
      temperatureColor: temperatureColor ?? this.temperatureColor,
      locationColor: locationColor ?? this.locationColor,
      forecastTextColor: forecastTextColor ?? this.forecastTextColor,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
      covariant ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t)!,
      secondaryTextColor: Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t)!,
      errorButtonColor: Color.lerp(errorButtonColor, other.errorButtonColor, t)!,
      temperatureColor: Color.lerp(temperatureColor, other.temperatureColor, t)!,
      locationColor: Color.lerp(locationColor, other.locationColor, t)!,
      forecastTextColor: Color.lerp(forecastTextColor, other.forecastTextColor, t)!,
    );
  }
}