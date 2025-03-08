import 'package:dio/dio.dart';
import 'package:fasio_twist/api/api.dart';
import 'package:fasio_twist/config/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authVM = ChangeNotifierProvider<AuthVM>((ref) => AuthVM());

class AuthVM extends ChangeNotifier {
  String? token;
  final Dio dio = Dio();
  bool isLoading = true;

  AuthVM() {
    initializeHive();
  }

  void initializeHive() async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic>? data = await HiveDB.fromDb('authBox', 'token');
    token = data?['token'];
    isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      dio.options.headers = {'Content-Type': 'application/json'};

      final response = await dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        token = response.data['token'];
        await HiveDB.toDb('authBox', 'token', {'token': token});
        notifyListeners();
        print("Login Success: $response");
        return true;
      }
    } catch (e) {
      print("Error during login: $e");
      if (e is DioException) {
        print("Dio error: ${e.message}");
        print("Response: ${e.response?.data}");
      }
    }
    return false;
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      dio.options.headers = {'Content-Type': 'application/json'};

      final response = await dio.post(
        ApiEndpoints.signUp,
        data: {'name': name, 'email': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        token = response.data['token'];
        await HiveDB.toDb('authBox', 'token', {'token': token});
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error during signup: $e");
      if (e is DioException) {
        print("Dio error: ${e.message}");
        print("Response: ${e.response?.data}");
      }
    }
    return false;
  }

  Future<void> logout() async {
    await HiveDB.deleteFromDb('authBox', 'token');
    token = null;
    notifyListeners();
  }
}
