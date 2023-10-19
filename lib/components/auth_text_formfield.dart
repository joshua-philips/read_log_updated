import 'package:books_log_migration/configuration/constants.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final bool? autofocus;
  final String? label;
  const AuthTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator,
      required this.obscureText,
      this.autofocus,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        gapH8,
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
          ),
          obscureText: obscureText,
          validator: validator,
          autofocus: autofocus ?? false,
        ),
      ],
    );
  }
}
