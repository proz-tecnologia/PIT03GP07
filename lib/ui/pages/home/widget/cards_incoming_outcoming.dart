import 'package:belt/extension/extension_double.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardsIncomingOutcoming extends StatelessWidget {
  CardsIncomingOutcoming(
      {required this.icoming,
      required this.outcoming,
      required this.isVisibility,
      super.key});
  double icoming;
  double outcoming;
  bool isVisibility;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          elevation: 1,
          child: SizedBox(
            height: 55,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Entradas",style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                Text(
                  isVisibility
                      ? icoming.formatBRL
                      : icoming.formatBRL.replaceAll(RegExp(r'[0-9]'), 'X'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          elevation: 1,
          child: SizedBox(
            height: 55,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Saidas",style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  Text(
                    isVisibility
                        ? outcoming.formatBRL
                        : outcoming.formatBRL.replaceAll(RegExp(r'[0-9]'), 'X'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
