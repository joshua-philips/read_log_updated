import 'package:books_log_migration/configuration/constants.dart';
import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const BlueButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fixedSize: const Size(double.maxFinite, 45),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        backgroundColor: myBlue,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
