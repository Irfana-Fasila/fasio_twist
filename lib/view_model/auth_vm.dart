import 'package:dio/dio.dart';
import 'package:fasio_twist/api/api.dart';
import 'package:fasio_twist/config/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Login Model
class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

// Signup Model
class SignupModel {
  final String name;
  final String email;
  final String password;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'password': password};
}

final authVM = ChangeNotifierProvider<AuthVM>((ref) => AuthVM());

class AuthVM extends ChangeNotifier {
  String? token;
  String? userEmail;
  String? userName;
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
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> login(LoginModel loginModel) async {
    try {
      dio.options.headers = {'Content-Type': 'application/json'};

      final response = await dio.post(
        ApiEndpoints.login,
        data: loginModel.toJson(),
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        token = response.data['token'];
        userEmail = loginModel.email;
        // Assuming the API returns the name in the response, if not, it will be null
        userName = response.data['name'];

        await HiveDB.toDb('authBox', 'userData', {
          'token': token,
          'email': userEmail,
          'name': userName,
        });
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

        await HiveDB.toDb('authBox', 'userData', {
          'token': token,
          'email': userEmail,
          'name': userName,
        });
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
    await HiveDB.deleteFromDb('authBox', 'userData');
    token = null;
    userEmail = null;
    userName = null;
    notifyListeners();
  }

  // Getters for UI access
  String get email => userEmail ?? '';
  String get name => userName ?? '';
}
