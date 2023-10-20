import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SpinKitRing(
        color: AppColors.primary2,
      ),
    ),
  );
}

void showMessageDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void showMessageSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        )),
      ],
    ),
  ));
}
