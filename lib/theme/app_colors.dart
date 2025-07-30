import 'package:flutter/material.dart';

final class AppColors extends ThemeExtension<AppColors> {
  AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.commentTileColor,
    required this.errorRed,
    required this.successGreen,
  });

  final Color? primary;
  final Color? secondary;
  final Color? background;
  final Color? commentTileColor;
  final Color? errorRed;
  final Color? successGreen;

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? errorRed,
    Color? successGreen,
    Color? commentTileColor,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      errorRed: errorRed ?? this.errorRed,
      successGreen: successGreen ?? this.successGreen,
      commentTileColor: commentTileColor ?? this.commentTileColor,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      background: Color.lerp(background, other.background, t),
      errorRed: Color.lerp(errorRed, other.errorRed, t),
      successGreen: Color.lerp(successGreen, other.successGreen, t),
      commentTileColor: Color.lerp(commentTileColor, other.commentTileColor, t),
    );
  }
}
