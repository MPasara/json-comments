import 'package:comments/common/domain/notifiers/locale_notifier.dart';
import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/common/presentation/image_assets.dart';
import 'package:comments/common/presentation/widgets/theme_switcher_row.dart';
import 'package:comments/common/utils/constants/locale_constants.dart';
import 'package:comments/features/comments/presentation/widgets/app_drawer_tile.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeNotifierProvider);
    return Drawer(
      backgroundColor: context.appColors.background,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: context.appColors.primary),
                ),
                Spacer(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                S.of(context).change_language,
                style: context.appTextStyles.regular,
              ),
            ),
            AppDrawerTile(
              onTap: () => ref
                  .read(localeNotifierProvider.notifier)
                  .setLocale(Locale(LocaleConstants.eng)),
              leadingIconPath: ImageAssets.englandFlag,
              tileText: S.of(context).english,
              selected: selectedLocale.languageCode == LocaleConstants.eng,
            ),
            AppDrawerTile(
              onTap: () => ref
                  .read(localeNotifierProvider.notifier)
                  .setLocale(Locale(LocaleConstants.cro)),
              leadingIconPath: ImageAssets.croatiaFlag,
              tileText: S.of(context).croatian,
              selected: selectedLocale.languageCode == LocaleConstants.cro,
            ),
            AppDrawerTile(
              onTap: () => ref
                  .read(localeNotifierProvider.notifier)
                  .setLocale(Locale(LocaleConstants.esp)),
              leadingIconPath: ImageAssets.spainFlag,
              tileText: S.of(context).spanish,
              selected: selectedLocale.languageCode == LocaleConstants.esp,
            ),
            AppDrawerTile(
              onTap: () => ref
                  .read(localeNotifierProvider.notifier)
                  .setLocale(Locale(LocaleConstants.fr)),
              leadingIconPath: ImageAssets.franceFlag,
              tileText: S.of(context).french,
              selected: selectedLocale.languageCode == LocaleConstants.fr,
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                S.of(context).change_theme,
                style: context.appTextStyles.regular,
              ),
            ),
            ThemeSwitcherRow(),
          ],
        ),
      ),
    );
  }
}
