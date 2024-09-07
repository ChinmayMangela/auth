import 'package:auth/presentation/screens/log_in_screen.dart';
import 'package:auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool isLogin = true;

  void _toggleState() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogin
          ? LogInScreen(onSignUpClick: _toggleState)
          : SignUpScreen(onLoginClick: _toggleState),
    );
  }
}
