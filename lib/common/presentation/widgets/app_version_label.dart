import 'package:comments/common/domain/notifiers/app_info_notifier/app_info_notifier.dart';
import 'package:comments/common/domain/notifiers/app_info_notifier/app_info_state.dart';
import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppVersionLabel extends ConsumerWidget {
  const AppVersionLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appInfoNotifierProvider);
    return switch (state) {
      AppInfoInitial() => const SizedBox(),
      AppInfoLoading() => CircularProgressIndicator(
        color: context.appColors.primary,
      ),
      AppInfoData(:final appInfo) => Text(
        '${S.of(context).version} ${appInfo.version}-${appInfo.buildNumber}',
        style: context.appTextStyles.regular,
      ),
      AppInfoError(failure: final failure) => Text(failure.title),
    };
  }
}
