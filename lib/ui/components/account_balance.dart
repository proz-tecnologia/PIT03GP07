import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proz_project_finance/ui/components/movement_value.dart';

class AccontBalance extends StatefulWidget {

  const AccontBalance({super.key});

  @override
  State<AccontBalance> createState() => _AccontBalanceState();
}

class _AccontBalanceState extends State<AccontBalance> {

  bool isVisibility = false;

  void changeVisivility() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Saldo em contas",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white ,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5,bottom: 10),
          child: Text(
            isVisibility ? "R\$ 200.350,00" : "R\$ xxx.xxx,xx",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        TextButton(
          onPressed: changeVisivility,
          child: Icon(
            isVisibility ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        MovimentValue(isVisibility: isVisibility),
      ],
    );
  }
}