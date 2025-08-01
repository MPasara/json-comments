import 'package:comments/common/data/repositories/app_info_repository.dart';
import 'package:comments/common/domain/notifiers/state/base_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appInfoNotifierProvider = NotifierProvider<AppInfoNotifier, BaseState>(
  AppInfoNotifier.new,
  name: 'App Info Notifier Provider',
);

class AppInfoNotifier extends Notifier<BaseState> {
  late AppInfoRepository _appInfoRepository;

  @override
  BaseState build() {
    _appInfoRepository = ref.watch(appInfoRepositoryProvider);
    getAppInfo();
    return BaseState.initial();
  }

  Future getAppInfo() async {
    state = BaseState.loading();

    final eitherFailureOrAppInfo = await _appInfoRepository.getVersionNumber();
    eitherFailureOrAppInfo.fold(
      (failure) => state = BaseState.error(failure),
      (appInfo) => state = BaseState.data(appInfo),
    );
  }
}
