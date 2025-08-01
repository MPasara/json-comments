import 'package:comments/common/data/package_info_service.dart';
import 'package:comments/common/domain/entities/app_info.dart';
import 'package:comments/common/domain/failure.dart';
import 'package:comments/common/utils/either.dart';
import 'package:comments/generated/l10n.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appInfoRepositoryProvider = Provider<AppInfoRepository>(
  (ref) => AppInfoRepositoryImpl(ref.watch(packageInfoServiceProvider)),
);

abstract class AppInfoRepository {
  EitherFailureOr<AppInfo> getVersionNumber();
}

class AppInfoRepositoryImpl implements AppInfoRepository {
  final PackageInfoService _packageInfoService;

  AppInfoRepositoryImpl(this._packageInfoService);

  @override
  EitherFailureOr<AppInfo> getVersionNumber() async {
    try {
      final versionNumber = await _packageInfoService.getVersionNumber();
      return Right(versionNumber);
    } catch (e, st) {
      return Left(
        Failure(
          title: S.current.fetch_app_version_failed,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }
}
