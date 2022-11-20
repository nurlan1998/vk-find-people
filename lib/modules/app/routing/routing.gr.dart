// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../auth/view/vk_auth_page.dart' as _i4;
import '../view/vk_dashboard_page.dart' as _i5;
import '../view/vk_splash_page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          builder: (_) {
            return const _i3.SplashPage();
          },
        ),
    VkAuthRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          builder: (_) {
            return const _i4.VkAuthPage();
          },
        ),
    VkDashboardRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          builder: (_) {
            return const _i5.VkDashboardPage();
          },
        ),
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i1.RouteConfig(
          VkAuthRoute.name,
          path: '/vk/implicit-flow-auth',
        ),
        _i1.RouteConfig(
          VkDashboardRoute.name,
          path: '/dashboard',
        ),
      ];
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute()
      : super(
          name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

class VkAuthRoute extends _i1.PageRouteInfo {
  const VkAuthRoute()
      : super(
          name,
          path: '/vk/implicit-flow-auth',
        );

  static const String name = 'VkAuthRoute';
}

class VkDashboardRoute extends _i1.PageRouteInfo {
  const VkDashboardRoute()
      : super(
          name,
          path: '/dashboard',
        );

  static const String name = 'VkDashboardRoute';
}
