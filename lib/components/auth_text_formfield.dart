import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final bool? autofocus;
  const AuthTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.prefixIcon,
      required this.validator,
      required this.obscureText,
      this.autofocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.green,
          size: 20,
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.all(8),
      ),
      obscureText: obscureText,
      validator: validator,
      autofocus: autofocus ?? false,
    );
  }
}
