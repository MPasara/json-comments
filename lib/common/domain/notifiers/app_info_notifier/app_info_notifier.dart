import 'package:comments/common/data/repositories/app_info_repository.dart';
import 'package:comments/common/domain/notifiers/app_info_notifier/app_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appInfoNotifierProvider = NotifierProvider<AppInfoNotifier, AppInfoState>(
  AppInfoNotifier.new,
  name: 'App Info Notifier Provider',
);

class AppInfoNotifier extends Notifier<AppInfoState> {
  late AppInfoRepository _appInfoRepository;

  @override
  AppInfoState build() {
    _appInfoRepository = ref.watch(appInfoRepositoryProvider);
    getAppInfo();
    return AppInfoState.initial();
  }

  Future getAppInfo() async {
    state = AppInfoState.loading();

    final eitherFailureOrAppInfo = await _appInfoRepository.getVersionNumber();
    eitherFailureOrAppInfo.fold(
      (failure) => state = AppInfoState.error(failure),
      (appInfo) => state = AppInfoState.data(appInfo),
    );
  }
}
