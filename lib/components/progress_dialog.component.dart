import 'package:flutter/material.dart';

class ProgressDialog {
  BuildContext context;
  bool _isShowing = false;

  ProgressDialog(this.context);

  void show() {
    if (_isShowing) return;
    _isShowing = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.white,
              content: SizedBox(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Processando...",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ));
  }

  void hide() {
    if (!_isShowing) return;
    _isShowing = false;
    Navigator.pop(context);
  }
}
