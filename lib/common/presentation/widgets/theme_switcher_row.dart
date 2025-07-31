import 'package:comments/common/domain/notifiers/theme_notifier.dart';
import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/common/presentation/widgets/theme_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitcherRow extends ConsumerWidget {
  const ThemeSwitcherRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ThemeSwitchButton.light(
                  bgColor: selectedTheme == ThemeMode.light
                      ? context.appColors.primary
                      : context.appColors.secondary,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref
                        .read(themeNotifierProvider.notifier)
                        .setThemeMode(ThemeMode.light);
                  },
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ThemeSwitchButton.system(
                  bgColor: selectedTheme == ThemeMode.system
                      ? context.appColors.primary
                      : context.appColors.secondary,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref
                        .read(themeNotifierProvider.notifier)
                        .setThemeMode(ThemeMode.system);
                  },
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ThemeSwitchButton.dark(
                  bgColor: selectedTheme == ThemeMode.dark
                      ? context.appColors.primary
                      : context.appColors.secondary,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref
                        .read(themeNotifierProvider.notifier)
                        .setThemeMode(ThemeMode.dark);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
