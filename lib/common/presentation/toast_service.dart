import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static void showError(BuildContext context, String message, {String? title}) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? S.of(context).error),
      description: Text(message, style: context.appTextStyles.toast),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    String? title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? S.of(context).success),
      description: Text(message, style: context.appTextStyles.toast),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 3),
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static void showInfo(BuildContext context, String message, {String? title}) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(title ?? S.of(context).info),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      dragToClose: true,
    );
  }
}
