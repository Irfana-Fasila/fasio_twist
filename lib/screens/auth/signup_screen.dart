import 'dart:ui';

import 'package:fasio_twist/route/route.dart';
import 'package:fasio_twist/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void submitForm() async {
      if (formKey.currentState!.validate()) {
        final signupModel = SignupModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          age: ageController.text,
        );

        bool success = await ref.read(authVM).signUp(signupModel);

        if (success) {
          routeX.go('/home');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Account created successfully!',
                style: TextStyle(color: Color.fromRGBO(161, 193, 222, 1)),
              ),
              backgroundColor: const Color.fromARGB(255, 239, 224, 233),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign up failed'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 248, 178, 224),
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
                color: const Color.fromRGBO(251, 100, 203, 1).withOpacity(0.1),
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

                    const SizedBox(height: 40),

                    // Form card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(234, 145, 145, 1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromRGBO(238, 160, 160, 1).withOpacity(0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 8),

                                const Text(
                                  'Sign up to start shopping',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 32),

                                // Name field
                                TextFormField(
                                  controller: nameController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: const TextStyle(color: Colors.white70),
                                    prefixIcon: const Icon(Icons.person, color: Colors.white70),
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
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                    ),
                                    errorStyle: const TextStyle(color: Colors.redAccent),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    if (value.length < 2) {
                                      return 'Name must be at least 2 characters';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: ageController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Age',
                                    labelStyle: const TextStyle(color: Colors.white70),
                                    prefixIcon: const Icon(Icons.numbers, color: Colors.white70),
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
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                    ),
                                    errorStyle: const TextStyle(color: Colors.redAccent),
                                  ),
                                  keyboardType: TextInputType.number, // Added to ensure numeric input
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your age';
                                    }
                                    // Convert string to integer for validation
                                    final age = int.tryParse(value);
                                    if (age == null) {
                                      return 'Please enter a valid number';
                                    }
                                    if (age < 0) {
                                      return 'Age cannot be negative';
                                    }
                                    if (age < 13) {
                                      return 'You must be at least 13 years old';
                                    }
                                    if (age > 120) {
                                      return 'Please enter a realistic age';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Email field
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.white),
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
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                    ),
                                    errorStyle: const TextStyle(color: Colors.redAccent),
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
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
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
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                    ),
                                    errorStyle: const TextStyle(color: Colors.redAccent),
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

                                // Sign Up button
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF9C27B0),
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
                                    onPressed: submitForm,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      child: Text(
                                        'SIGN UP',
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

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Color.fromARGB(179, 9, 14, 23)),
                        ),
                        GestureDetector(
                          onTap: () {
                            routeX.goNamed('login'); // Assuming 'login' is the route name
                          },
                          child: const Text(
                            'Login',
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
    );
  }
}
