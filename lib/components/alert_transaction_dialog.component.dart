import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlertTransactionDialog {
  BuildContext context;

  AlertTransactionDialog(this.context);

  show(
      {required String title,
      required String message,
      String? positiveText,
      String? negativeText}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          child: Lottie.asset('assets/lottie/check.json'),
        ),
      ),
    );
  }

  showInfo(
      {required String title,
      required String message,
      String? actionText,
      VoidCallback? action}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          child: Text(message),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
              onPressed: () {
                if (action != null) action();
                Navigator.pop(context);
              },
              child: Text(actionText ?? 'Entendi')),
        ],
      ),
    );
  }
}
