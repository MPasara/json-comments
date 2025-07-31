import 'package:comments/theme/app_colors.dart';
import 'package:comments/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
