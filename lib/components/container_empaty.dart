import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ContainerEmpaty extends StatelessWidget {
  const ContainerEmpaty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
              child: Text(
            "Você ainda não possui movimentações",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          )),
          SizedBox(
              height: 300, child: Lottie.asset('assets/lottie/money.json')),
        ],
      ),
    );
  }
}
