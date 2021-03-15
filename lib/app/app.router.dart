// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../ui/dashboard/dashboard.dart';
import '../ui/page_not_found/page_not_found.dart';
import '../ui/splash/splash.dart';

class Routes {
  static const String splashPage = '/';
  static const String dashboardPage = '/dashboard-page';
  static const String pageNotFoundPage = '*';
  static const all = <String>{
    splashPage,
    dashboardPage,
    pageNotFoundPage,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.dashboardPage, page: DashboardPage),
    RouteDef(Routes.pageNotFoundPage, page: PageNotFoundPage),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SplashPage(),
        settings: data,
      );
    },
    DashboardPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => DashboardPage(),
        settings: data,
      );
    },
    PageNotFoundPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PageNotFoundPage(),
        settings: data,
      );
    },
  };
}
