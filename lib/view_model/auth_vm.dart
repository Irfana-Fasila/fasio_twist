import 'package:dio/dio.dart';
import 'package:fasio_twist/api/api.dart';
import 'package:fasio_twist/config/helper.dart';
import 'package:fasio_twist/config/hive.dart';
import 'package:fasio_twist/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authVM = ChangeNotifierProvider<AuthVM>((ref) => AuthVM());

class AuthVM extends ChangeNotifier {
  String? token;
  String? userEmail;
  String? userName;
  int? userAge; // Changed from String to int
  final Dio dio = Dio();
  bool isLoading = true;

  AuthVM() {
    initializeHive();
  }

  void initializeHive() async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic>? data = await HiveDB.fromDb('authBox', 'userData');
    if (data != null) {
      token = data['token'];
      userEmail = data['email'];
      userName = data['name'];
      userAge = data['age'] is String ? int.tryParse(data['age']) ?? 0 : data['age'] as int?; // Handle possible String from storage
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> login(LoginModel loginModel) async {
    try {
      dio.options.headers = {'Content-Type': 'application/json'};
      logX("Requesting: ${ApiEndpoints.login}");
      final response = await dio.post(
        ApiEndpoints.login,
        data: loginModel.toJson(),
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        token = response.data['token'];
        userEmail = loginModel.email;
        userName = response.data['name'];
        userAge = response.data['age'] is String ? int.tryParse(response.data['age']) ?? 0 : response.data['age'] as int?; // Convert API response if needed

        await HiveDB.toDb('authBox', 'userData', {
          'token': token,
          'email': userEmail,
          'name': userName,
          'age': userAge,
        });
        notifyListeners();
        logX("Login Success: $response");
        return true;
      }
    } catch (e) {
      logX("Error during login: $e");
      if (e is DioException) {
        logX("Dio error: ${e.message}");
        logX("Response: ${e.response?.data}");
      }
    }
    return false;
  }

  Future<bool> signUp(SignupModel signupModel) async {
    try {
      dio.options.headers = {'Content-Type': 'application/json'};

      final response = await dio.post(
        ApiEndpoints.signUp,
        data: signupModel.toJson(),
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        token = response.data['token'];
        userEmail = signupModel.email;
        userName = signupModel.name;
        userAge = signupModel.age;

        await HiveDB.toDb('authBox', 'userData', {
          'token': token,
          'email': userEmail,
          'name': userName,
          'age': userAge,
        });
        notifyListeners();
        return true;
      }
    } catch (e) {
      logX("Error during signup: $e");
      if (e is DioException) {
        logX("Dio error: ${e.message}");
        logX("Response: ${e.response?.data}");
      }
    }
    return false;
  }

  Future<void> logout() async {
    await HiveDB.deleteFromDb('authBox', 'userData');
    token = null;
    userEmail = null;
    userName = null;
    userAge = null;
    notifyListeners();
  }

  String get email => userEmail ?? '';
  String get name => userName ?? '';
  int? get age => userAge;
}
