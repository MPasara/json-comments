import 'package:comments/theme/app_colors.dart';
import 'package:comments/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

final primaryTheme = _getTheme(
  appColors: AppColors(
    primary: Colors.black,
    secondary: Colors.deepPurpleAccent,
    background: Color.fromARGB(255, 240, 239, 239),
    commentTileColor: Colors.white,
    errorRed: Colors.redAccent,
    successGreen: Colors.greenAccent,
  ),
);

final secondaryTheme = _getTheme(
  appColors: AppColors(
    primary: Colors.white,
    secondary: Colors.deepPurpleAccent,
    background: Color(0xff121212),
    commentTileColor: Color(0xff1e1e1e),
    errorRed: Colors.redAccent,
    successGreen: Colors.greenAccent,
  ),
);

ThemeData _getTheme({required AppColors appColors}) {
  return ThemeData(
    primarySwatch: Colors.cyan,
    colorScheme: ThemeData().colorScheme.copyWith(
      primary: appColors.primary,
      secondary: appColors.secondary,
    ),
    scaffoldBackgroundColor: appColors.background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appColors.primary,
      selectionColor: appColors.primary?.withValues(alpha: 0.2),
      selectionHandleColor: appColors.primary,
    ),
    extensions: [
      appColors,
      AppTextStyles(
        regular: TextStyle(
          fontSize: 14,
          color: appColors.primary,
          fontWeight: FontWeight.normal,
        ),
        bold: TextStyle(
          fontSize: 14,
          color: appColors.primary,
          fontWeight: FontWeight.bold,
        ),
        boldLarge: TextStyle(
          fontSize: 18,
          color: appColors.primary,
          fontWeight: FontWeight.bold,
        ),
        title: TextStyle(
          fontSize: 20,
          color: appColors.primary,
          fontWeight: FontWeight.bold,
        ),
        toast: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        error: TextStyle(
          fontSize: 24,
          color: appColors.errorRed,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
