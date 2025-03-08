import 'package:fasio_twist/screens/auth/login_screen.dart';
import 'package:fasio_twist/screens/auth/signup_screen.dart';
import 'package:fasio_twist/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class RouteModel {
  final int id;
  final String name;
  final String routeName;
  final Widget widget;

  const RouteModel({
    required this.id,
    required this.name,
    required this.routeName,
    required this.widget,
  });
}

class MainRoutes {
  static const String login = "login";
  static const String signUp = "sign-up";
  static const String home = "home";

  static List<RouteModel> mainRouteList = [
    const RouteModel(id: 0, name: "testing", routeName: login, widget: LoginScreen()),
    const RouteModel(id: 1, name: "demo", routeName: signUp, widget: SignUpScreen()),
    const RouteModel(id: 2, name: "home", routeName: home, widget: HomeScreen()),
  ];
}
