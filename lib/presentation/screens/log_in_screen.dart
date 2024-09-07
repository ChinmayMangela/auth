import 'package:auth/main.dart';
import 'package:auth/presentation/widgets/custom_button.dart';
import 'package:auth/presentation/widgets/custom_text_field.dart';
import 'package:auth/services/authentication/authentication_service.dart';
import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({
    super.key,
    required this.onSignUpClick,
  });

  final void Function() onSignUpClick;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticationService _auth = AuthenticationService();
  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logIn() async {
    Utils.showCircularProgressIndicator(context);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty && password.isEmpty) {
      Utils.showSnackBar('Enter your credentials');
      return;
    }

    await _auth.logInWithEmail(email, password);
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, color: Colors.black, size: 100),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 10),
            _buildPasswordField(),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Log In',
              onTap: _logIn,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account??'),
                const SizedBox(width: 2),
                TextButton(
                  onPressed: widget.onSignUpClick,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      hintText: 'Email',
      isPasswordField: false,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      hintText: 'Password',
      isPasswordField: true,
      obscureText: obscureText,
      togglePasswordVisibility: _togglePasswordVisibility,
    );
  }
}
