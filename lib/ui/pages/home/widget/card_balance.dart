import 'package:flutter/material.dart';
import 'package:money/extensions/double.extension.dart';

// ignore: must_be_immutable
class CardBalance extends StatelessWidget {
  String name;
  bool isVisibility;
  double total;
  double totalIncome;
  double totalExpense;
  Function iconButton;
  CardBalance(this.name,this.isVisibility, this.total, this.iconButton,this.totalIncome,this.totalExpense,{super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Olá $name", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
            const SizedBox(height: 10),
            const Text("Saldo Disponível:",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16)),
            const SizedBox(height: 5),
            Text(
              isVisibility
                  ? total.toBRL
                  : total.toBRL.replaceAll(RegExp(r'[0-9]'), 'X'),
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              iconSize: 20,
                onPressed: () => iconButton(),
                icon: Icon(isVisibility
                    ? Icons.visibility_off
                    : Icons.visibility)),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 50,
              width: 100,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(177, 135, 223, 77),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: [
                  const Text(
                    "Entrada",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                   Text(isVisibility?
                    totalIncome.toBRL :
                    totalIncome.toBRL.replaceAll(RegExp(r'[0-9]'), 'X'),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 50,
              width: 100,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(176, 199, 58, 58),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: [
                  const Text(
                    "Saida",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                   Text(isVisibility?
                    totalExpense.toBRL :
                    totalExpense.toBRL.replaceAll(RegExp(r'[0-9]'), 'X'),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
