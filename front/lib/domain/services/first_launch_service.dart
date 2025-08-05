import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class FirstLaunchService {
  static const String _firstLaunchKey = 'is_first_launch';

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  Future<void> markAsLaunched() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }
}
