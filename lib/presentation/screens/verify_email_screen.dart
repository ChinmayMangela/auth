import 'dart:async';

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
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      _authenticationService.sendEmailVerification();

      Timer.periodic(const Duration(seconds: 3), (_) {
        return checkEmailVerified();
      });
    }
  }

  void checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) () => _timer!.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? const HomeScreen() : _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'A verification email has been sent to your account'),
            ElevatedButton(
              onPressed: () async {
                await _authenticationService.sendVerificationEmail();
              },
              child: const Row(
                children: [
                  Icon(Icons.email),
                  Text('Resend Email'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await _authenticationService.signOut();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
