import 'package:auth/presentation/screens/home_screen.dart';
import 'package:auth/services/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthenticationService _authenticationService = AuthenticationService();
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified) {
      _authenticationService.sendEmailVerification();
    }
  }



  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? const HomeScreen() : _buildBody();
  }

  Widget _buildBody() {
    return const Column();
  }
}
