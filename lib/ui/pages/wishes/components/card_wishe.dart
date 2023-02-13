import 'package:flutter/material.dart';
import 'package:money/extensions/double.extension.dart';
import 'package:money/models/wishe.model.dart';

// ignore: must_be_immutable
class CardWishe extends StatelessWidget {
  Wishes wishe;
  CardWishe(this.wishe,{super.key});

  DateTime dateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Text(wishe.description, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          const SizedBox(height: 10),
          const Text("Valor desejado:"),
          const SizedBox(height: 5),
          Text(wishe.value.toBRL, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
          const SizedBox(height: 10),
          const Text("Data limite:"),
          const SizedBox(height: 5),
          Text("${wishe.dateExpectedt!.day}/${wishe.dateExpectedt!.month}/${wishe.dateExpectedt!.year}"),
          Row(children: [
            const Text("Status: "),
            wishe.dateExpectedt!.compareTo(dateNow) == 1?
              const Text("Em dia", style: TextStyle(color: Colors.green))
              : const Text("atrasado", style: TextStyle(color: Colors.red))
          ],)
      ],
    );
  }

}