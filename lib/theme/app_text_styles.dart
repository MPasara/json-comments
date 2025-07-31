import 'package:flutter/material.dart';

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  AppTextStyles({
    required this.regular,
    required this.bold,
    required this.boldLarge,
    required this.title,
  });

  final TextStyle? regular;
  final TextStyle? bold;
  final TextStyle? boldLarge;
  final TextStyle? title;

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? regular,
    TextStyle? bold,
    TextStyle? boldLarge,
    TextStyle? title,
  }) {
    return AppTextStyles(
      regular: regular ?? this.regular,
      bold: bold ?? this.bold,
      boldLarge: boldLarge ?? this.boldLarge,
      title: title ?? this.title,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
    covariant ThemeExtension<AppTextStyles>? other,
    double t,
  ) {
    if (other is! AppTextStyles) {
      return this;
    }

    return AppTextStyles(
      regular: TextStyle.lerp(regular, other.regular, t),
      bold: TextStyle.lerp(bold, other.bold, t),
      boldLarge: TextStyle.lerp(boldLarge, other.boldLarge, t),
      title: TextStyle.lerp(title, other.title, t),
    );
  }
}
