import 'package:belt/extension/extension_double.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BalanceValue extends StatelessWidget {
  BalanceValue({required this.value, required this.isVisibility, super.key});
  double value;
  bool isVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
            child: Text(
          "Saldo Disponível",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )),
        const SizedBox(height: 10),
        Center(
            child: Text(
          isVisibility
              ? value.formatBRL
              : value.formatBRL.replaceAll(RegExp(r'[0-9]'), 'X'),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ))
      ],
    );
  }
}
