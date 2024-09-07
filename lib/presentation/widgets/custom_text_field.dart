import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPasswordField,
    this.obscureText = false,
    this.togglePasswordVisibility,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPasswordField;
  final bool obscureText;
  final void Function()? togglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: isPasswordField
              ? IconButton(
                  onPressed: togglePasswordVisibility,
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          )),
    );
  }
}
