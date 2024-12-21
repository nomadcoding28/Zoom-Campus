import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final IconData icon;
  final TextEditingController controller;
  const Input({
    super.key,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
