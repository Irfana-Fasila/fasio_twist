import 'dart:ui';

import 'package:fasio_twist/model/auth_model.dart';
import 'package:fasio_twist/route/route.dart';
import 'package:fasio_twist/route/route_list.dart';
import 'package:fasio_twist/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool isLoading = false;
  void submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final loginModel = LoginModel(
        email: emailController.text,
        password: passwordController.text,
      );

      await ref.read(authVM).login(loginModel).then((value) {
        if (value) {
          routeX.goNamed(MainRoutes.home);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Welcome back!',
                style: TextStyle(color: Color.fromRGBO(161, 193, 222, 1)),
              ),
              backgroundColor: const Color.fromARGB(255, 55, 71, 95),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed'),
              backgroundColor: Color.fromARGB(255, 73, 45, 124),
            ),
          );
        }
      }).whenComplete(() {
        // Reset loading state when complete
        setState(() => isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 95, 103, 190),
                    Color.fromRGBO(228, 226, 234, 1),
                  ],
                ),
              ),
            ),

            // Decorative elements
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 71, 48, 146).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            Positioned(
              bottom: 100,
              right: -50,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(75),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.08),

                      // Logo
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.shopping_bag_rounded,
                            size: 60,
                            color: Color.fromARGB(255, 143, 185, 244),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Form card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 131, 174, 206).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color.fromARGB(255, 170, 170, 244).withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Welcome Back',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Sign in to continue shopping',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 32),

                                  // Email field
                                  TextFormField(
                                    controller: emailController,
                                    focusNode: emailFocusNode,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.white),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(passwordFocusNode);
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: const TextStyle(color: Colors.white70),
                                      prefixIcon: const Icon(Icons.email, color: Colors.white70),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.white30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.white, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 39, 1, 113), width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 2, 6, 119), width: 2),
                                      ),
                                      errorStyle: const TextStyle(color: Color.fromARGB(255, 216, 217, 221)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  // Password field
                                  TextFormField(
                                    controller: passwordController,
                                    focusNode: passwordFocusNode,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.white),
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) => submitForm(),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: const TextStyle(color: Colors.white70),
                                      prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.white30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.white, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 134, 165, 209), width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 246, 242, 242), width: 2),
                                      ),
                                      errorStyle: const TextStyle(color: Color.fromARGB(255, 109, 132, 215)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 32),

                                  // Login button
// In your build method, modify the button:
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 84, 74, 145),
                                          Color.fromRGBO(228, 214, 249, 1),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromRGBO(210, 195, 232, 1).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : submitForm, // Disable button when loading
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        child: isLoading
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 134, 131, 202)),
                                                ),
                                              )
                                            : const Text(
                                                'LOGIN',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Sign Up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Color.fromARGB(179, 9, 14, 23)),
                          ),
                          GestureDetector(
                            onTap: () {
                              routeX.goNamed(MainRoutes.signUp);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color.fromRGBO(23, 17, 17, 1),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
