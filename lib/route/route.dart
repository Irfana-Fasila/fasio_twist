import 'package:fasio_twist/config/helper.dart';
import 'package:fasio_twist/config/no_route.dart';
import 'package:fasio_twist/route/route_list.dart';
import 'package:fasio_twist/screens/auth/login_screen.dart';
import 'package:fasio_twist/screens/home/home_screen.dart';
import 'package:fasio_twist/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GoRouter routeX = GoRouter(initialLocation: "/", redirectLimit: 3, errorBuilder: (context, state) => const NoRouteScreen(), navigatorKey: ConstanceData.navigatorKey, routes: buildRoutes());

List<RouteBase> buildRoutes() {
  return [
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation),
              child: child,
            );
          },
          child: Consumer(
            builder: (context, ref, child) {
              if (ref.watch(authVM).isLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (ref.watch(authVM).token == null) {
                return const LoginScreen();
              }
              return const HomeScreen();
            },
          ),
        );
      },
      routes: mainRoutes(),
    ),
  ];
}

List<GoRoute> mainRoutes() {
  List<GoRoute> mainRouteX = [];
  for (var route in MainRoutes.mainRouteList) {
    mainRouteX.add(
      GoRoute(
        path: route.routeName,
        name: route.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation),
                child: child,
              );
            },
            child: route.widget,
          );
        },
      ),
    );
  }
  return mainRouteX;
}
