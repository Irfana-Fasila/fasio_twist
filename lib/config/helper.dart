import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConstanceData {
  static const String appName = 'Faris Lectures';
  static const String restorationScopeId = "faris_lectures.0.1";
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static WidgetRef? notificationWidgetRef;
  static BuildContext? notificationContext;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

logX(dynamic data, [String? tag]) {
  final String tagData = tag != null ? tag.toString() : '';
  debugPrint("$tagData : $data");
}
