import 'package:auth/main.dart';
import 'package:auth/presentation/widgets/custom_button.dart';
import 'package:auth/presentation/widgets/custom_text_field.dart';
import 'package:auth/services/authentication/authentication_service.dart';
import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.onLoginClick,
  });

  final void Function() onLoginClick;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    Utils.showCircularProgressIndicator(context);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Utils.showSnackBar('Passwords does not match');
      return;
    }

    if (email.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
      Utils.showSnackBar('Please enter all the fields');
      return;
    }
    await _authenticationService.createUserWithEmail(email, password);
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
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
            const SizedBox(height: 10),
            _buildConfirmPasswordField(),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Log In',
              onTap: _signUp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account??'),
                const SizedBox(width: 2),
                TextButton(
                  onPressed: widget.onLoginClick,
                  child: const Text('Log In'),
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
      obscureText: obscurePassword,
      togglePasswordVisibility: _togglePasswordVisibility,
    );
  }

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: _confirmPasswordController,
      hintText: 'Confirm Password',
      obscureText: obscureConfirmPassword,
      isPasswordField: true,
      togglePasswordVisibility: _toggleConfirmPasswordVisibility,
    );
  }
}
