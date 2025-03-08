// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDB {
  HiveDB([String db = "SmartDB"]);
  static Future<bool> toDb(String db, String key, Map<String, dynamic> data) async {
    try {
      var box = await Hive.openBox(db);
      try {
        await box.put(key, jsonEncode(data));
        return true;
      } catch (ex) {
        print("$ex toDB");
        return false;
      }
    } catch (e) {
      print("$e toDB");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> fromDb(String db, String key) async {
    var box = await Hive.openBox(db);
    try {
      var data = await box.get(key);
      if (data != null) {
        return jsonDecode(data);
      } else {
        return null;
      }
    } catch (ex) {
      print("$ex FromDB$db");
      return null;
    }
  }

  static Future<bool> deleteFromDb(db, String key) async {
    var box = await Hive.openBox(db);
    try {
      await box.delete(key);
      return true;
    } catch (ex) {
      print("$ex deleteFromDb");
      return false;
    }
  }
}
