import 'package:package_info_plus/package_info_plus.dart';

abstract class AppInfoService {
  Future<String> getAppVersion();
}

class AppInfoServiceImpl implements AppInfoService {
  @override
  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
