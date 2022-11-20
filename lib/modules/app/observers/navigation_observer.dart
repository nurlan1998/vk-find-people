import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../logging/log.dart';

class NavigationObserver extends RouteObserver {
  static String currentRoute = '';

  void _setCurrentRoute(PageRoute<dynamic> route) {
    final screenName = extractRouteName(route);
    Log.i('[NavigationObserver] route set to: $screenName');
    currentRoute = screenName;
  }

  String extractRouteName(PageRoute<dynamic> route) {
    if (route.settings is MaterialPageX) {
      return (route.settings as MaterialPageX).routeData.path;
    }
    return route.settings.name ?? '/unknown';
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _setCurrentRoute(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _setCurrentRoute(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _setCurrentRoute(previousRoute);
    }
  }
}