import 'package:fasio_twist/route/route.dart';
import 'package:fasio_twist/route/route_list.dart';
import 'package:fasio_twist/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                await ref.watch(authVM).login(email, password).then((value) {
                  if (value) {
                    routeX.goNamed(MainRoutes.home);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
                  }
                });
              },
              child: Text('Login'),
            ),
            SizedBox(height: 30),
            InkWell(
                onTap: () {
                  routeX.goNamed(MainRoutes.signUp);
                },
                child: Text("SignUp")),
          ],
        ),
      ),
    );
  }
}
