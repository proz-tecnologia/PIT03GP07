import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovimentValue extends StatelessWidget {
 MovimentValue({super.key,required this.isVisibility});

  bool isVisibility;

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.arrow_upward,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Receitas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  isVisibility ? "R\$ 200.350,00" : "R\$ xxx.xxx,xx",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 15
                  ),
                )
              ],
            ),
            ],
          ),
          Row(
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const Text(
                  "Despesas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  isVisibility ? "R\$ 200.350,00" : "R\$ xxx.xxx,xx",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 4,
            ),
            const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.arrow_downward,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}