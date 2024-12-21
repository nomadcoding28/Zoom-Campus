import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final IconData icon;
  const Input({
    super.key,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
