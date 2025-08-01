import 'package:comments/common/data/repositories/locale_repository.dart';
import 'package:comments/common/presentation/toast_providers.dart';
import 'package:comments/common/utils/constants/locale_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale>(
  () => LocaleNotifier(),
  name: 'Locale Notifier Provider',
);

class LocaleNotifier extends Notifier<Locale> {
  late LocaleRepository _localRepository;

  @override
  Locale build() {
    _localRepository = ref.watch(localeRepositoryProvider);
    _initializeLocale();
    return const Locale(LocaleConstants.eng);
  }

  Future<void> _initializeLocale() async {
    final eitherFailureOrLanguage = await _localRepository.getLanguage();
    eitherFailureOrLanguage.fold(
      (failure) => ref.read(failureProvider.notifier).state = failure,
      (language) {
        state = Locale(language!);
      },
    );
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _localRepository.setLanguage(locale.languageCode);
  }
}
