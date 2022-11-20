import 'package:auto_route/annotations.dart';
import 'package:vk_find_people/modules/app/view/vk_splash_page.dart';

import '../../auth/view/vk_auth_page.dart';
import '../view/vk_dashboard_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: SplashPage,
      path: Routes.splashPage,
    ),
    AutoRoute(
      page: VkAuthPage,
      path: Routes.vkAuthPage,
    ),
    AutoRoute(
      page: VkDashboardPage,
      path: Routes.vkDashboardPage,
    ),
  ],
)
class $AppRouter {}

class Routes {
  static const String splashPage = '/';
  static const String vkAuthPage = '/vk/implicit-flow-auth';
  static const String vkDashboardPage = '/dashboard';
}
