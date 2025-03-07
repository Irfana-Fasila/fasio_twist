import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:fasio_twist/screens/home/home_screen.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool _isLogin = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _ageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
      _animationController.reset();
      _animationController.forward();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isLogin ? 'Welcome back!' : 'Account created successfully!',
            style: TextStyle(color: const Color.fromRGBO(161, 193, 222, 1)),
          ),
          backgroundColor: const Color.fromARGB(255, 239, 224, 233),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.from(alpha: 1, red: 0.973, green: 0.698, blue: 0.878),
                  Color.fromRGBO(228, 226, 234, 1),
                ],
              ),
            ),
          ),

          // Background decorative elements
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
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.08),

                      // App Logo with animated shadow
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
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.shopping_bag_rounded,
                            size: 60,
                            color: Color.from(alpha: 1, red: 0.961, green: 0.482, blue: 0.8),
                          ),
                        ),
                      ),

                      SizedBox(height: 40),

                      // Frosted glass card effect
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(234, 145, 145, 1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color.fromRGBO(238, 160, 160, 1).withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Title animation
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: Text(
                                      _isLogin
                                          ? 'Welcome Back'
                                          : 'Create Account',
                                      key: ValueKey(
                                          _isLogin ? 'login' : 'signup'),
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  SizedBox(height: 8),

                                  // Subtitle
                                  Text(
                                    _isLogin
                                        ? 'Sign in to continue shopping'
                                        : 'Sign up to start shopping',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 32),

                                  // Phone field
                                  TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      labelStyle:
                                          TextStyle(color: Colors.white70),
                                      prefixIcon: Icon(Icons.phone,
                                          color: Colors.white70),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: Colors.white30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent, width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent, width: 2),
                                      ),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      if (value.length < 10) {
                                        return 'Please enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20),

                                  // Age field
                                  TextFormField(
                                    controller: _ageController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      labelStyle:
                                          TextStyle(color: Colors.white70),
                                      prefixIcon: Icon(Icons.calendar_today,
                                          color: Colors.white70),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: Colors.white30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent, width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent, width: 2),
                                      ),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your age';
                                      }
                                      try {
                                        int age = int.parse(value);
                                        if (age < 13) {
                                          return 'You must be at least 13 years old';
                                        } else if (age > 120) {
                                          return 'Please enter a valid age';
                                        }
                                      } catch (e) {
                                        return 'Please enter a valid age';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 32),

                                  // Submit button with gradient and elevation
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF9C27B0),
                                          Color.fromRGBO(228, 214, 249, 1),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(210, 195, 232, 1)
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _submitForm,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Text(
                                          _isLogin ? 'LOGIN' : 'SIGN UP',
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

                      SizedBox(height: 32),

                      // Toggle between Login and Sign Up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLogin
                                ? "Don't have an account? "
                                : "Already have an account? ",
                            style: TextStyle(color: const Color.fromARGB(179, 9, 14, 23)),
                          ),
                          GestureDetector(
                            onTap: _toggleMode,
                            child: Text(
                              _isLogin ? 'Sign Up' : 'Login',
                              style: TextStyle(
                                color: const Color.fromRGBO(23, 17, 17, 1),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
