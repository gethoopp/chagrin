import 'package:akunku/repository/auth_repository/base_auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:akunku/view/Auth/login.dart';
import 'package:akunku/view/Auth/register.dart';
import 'package:akunku/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Auth,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    CustomRoute(
      page: SplashRoute.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: LoginRouteRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: ResgisteRoute.page,
      transitionsBuilder: TransitionsBuilders.slideRight,
    ),
  ];
}
