import 'package:comments/common/data/repositories/theme_repository.dart';
import 'package:comments/common/domain/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final failureProvider = StateProvider<Failure?>((_) => null);

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
  name: 'Theme Notifier Provider',
);

class ThemeNotifier extends Notifier<ThemeMode> {
  late ThemeRepository _themeRepository;

  @override
  ThemeMode build() {
    _themeRepository = ref.watch(themeRepositoryProvider);
    // Initialize theme asynchronously
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTheme();
    });
    return ThemeMode.system;
  }

  Future<void> _initializeTheme() async {
    print('ThemeNotifier: Initializing theme...');
    final eitherFailureOrThemeMode = await _themeRepository.getThemeMode();
    eitherFailureOrThemeMode.fold(
      (failure) {
        print('ThemeNotifier: Failed to get theme - ${failure.title}');
        ref.read(failureProvider.notifier).state = failure;
      },
      (themeMode) {
        print('ThemeNotifier: Loaded theme mode: $themeMode');
        if (state != themeMode) {
          state = themeMode;
          print('ThemeNotifier: State updated to $state');
        }
      },
    );
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    print('ThemeNotifier: Setting theme mode to $themeMode');
    // Update state immediately for UI responsiveness
    state = themeMode;
    print('ThemeNotifier: State updated to $state');

    // Persist the theme mode
    final result = await _themeRepository.setThemeMode(themeMode);
    result.fold(
      (failure) {
        print('ThemeNotifier: Failed to persist theme - ${failure.title}');
        ref.read(failureProvider.notifier).state = failure;
      },
      (_) {
        print('ThemeNotifier: Theme persisted successfully');
      },
    );
  }
}
