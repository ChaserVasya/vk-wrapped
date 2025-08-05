import 'package:auto_route/auto_route.dart';
import 'package:front/ui/screens/home_screen.dart';
import 'package:front/ui/screens/settings_screen.dart';
import 'package:front/ui/screens/statistics_screen.dart';
import 'package:front/ui/screens/token_setup_screen.dart';
import 'package:front/ui/screens/tracks_list_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: HomeRoute.page, initial: true),
    AutoRoute(path: '/tracks', page: TracksListRoute.page),
    AutoRoute(path: '/settings', page: SettingsRoute.page),
    AutoRoute(path: '/statistics', page: StatisticsRoute.page),
    AutoRoute(path: '/token-setup', page: TokenSetupRoute.page),
  ];
}
