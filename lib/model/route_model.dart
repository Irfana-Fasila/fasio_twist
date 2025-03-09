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
