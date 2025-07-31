import 'package:comments/common/domain/entities/app_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoServiceProvider = Provider<PackageInfoService>(
  (ref) => PackageInfoService(),
  name: 'package Info Service provider',
);

class PackageInfoService {
  Future<AppInfo> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appInfo = AppInfo.fromPackageInfo(packageInfo);
    return appInfo;
  }
}
