import 'package:comments/common/data/repositories/theme_repository.dart';
import 'package:comments/common/presentation/toast_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
  name: 'Theme Notifier Provider',
);

class ThemeNotifier extends Notifier<ThemeMode> {
  late ThemeRepository _themeRepository;

  @override
  ThemeMode build() {
    _themeRepository = ref.watch(themeRepositoryProvider);
    _initializeTheme();
    return ThemeMode.system;
  }

  Future<void> _initializeTheme() async {
    final eitherFailureOrThemeMode = await _themeRepository.getThemeMode();
    eitherFailureOrThemeMode.fold(
      (failure) {
        ref.read(failureProvider.notifier).state = failure;
      },
      (themeMode) {
        if (state != themeMode) {
          state = themeMode;
        }
      },
    );
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = themeMode;

    final result = await _themeRepository.setThemeMode(themeMode);
    result.fold((failure) {
      ref.read(failureProvider.notifier).state = failure;
    }, (_) => null);
  }
}
