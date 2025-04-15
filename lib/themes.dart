import 'package:flutter/material.dart';
import 'themes/app_theme_extension.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: const Color(0xFFF5F6F7),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF2A2A2A)),
      titleTextStyle: TextStyle(
        color: Color(0xFF2A2A2A),
        fontSize: 20,
        fontFamily: 'Roboto-Regular',
      ),
    ),
    textTheme: TextTheme(
      // Large temperature display (96sp)
      displayLarge: const TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto-Black',
        height: 1.2,
      ),
      // Location name (36sp)
      displayMedium: const TextStyle(
        fontSize: 36,
        fontFamily: 'Roboto-Thin',
        height: 1.4,
      ),
      // Forecast day and temperature (16sp)
      bodyMedium: const TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto-Regular',
        height: 1.2,
      ),
    ),
    extensions: const [
      AppThemeExtension.light,
    ],
  );
}

ThemeData light(BuildContext context) {
  return ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.pink,
      centerTitle: false,
      shadowColor: Colors.transparent,
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
    ),
  );
}

ThemeData dark(BuildContext context) {
  return ThemeData.dark();
}
