import 'package:flutter/material.dart';
import 'package:money/controllers/transactions.controller.dart';

class SetMonth extends StatelessWidget {
  Function functionDecrement;
  Function functionIncrement;
  int month;
  Function editTitle;
  SetMonth(this.functionDecrement,this.functionIncrement,this.month,this.editTitle,{super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => {functionDecrement(), editTitle()},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Text(
          "${_returnMonth(month)}",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        IconButton(
          onPressed: () => {functionIncrement(), editTitle()},
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  _returnMonth(int month) {
    switch (month) {
      case (1):
        return "Janeiro";
      case (2):
        return "Fevereiro";
      case (3):
        return "Março";
      case (4):
        return "Abril";
      case (5):
        return "Maio";
      case (6):
        return "Junho";
      case (7):
        return "Julho";
      case (8):
        return "Agosto";
      case (9):
        return "Setembro";
      case (10):
        return "Outubro";
      case (11):
        return "Novembro";
      case (12):
        return "Dezembro";
    }
  }
}
