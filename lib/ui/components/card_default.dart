import 'package:flutter/material.dart';

class CardMain extends StatelessWidget {
  Widget child;
  CardMain(this.child,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Color(0x61E2DCD8),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: child,
    );
  }
}
