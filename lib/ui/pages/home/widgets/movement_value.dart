import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proz_project_finance/strings.dart';
import 'package:proz_project_finance/extension/extension_double.dart';

class MovimentValue extends StatelessWidget {
  MovimentValue(this.isVisibility, this.outcoming, this.incoming, {super.key});

  bool isVisibility;
  double outcoming;
  double incoming;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  Strings.APP_REVENUES,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  incoming.formatBRL,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isVisibility ? Colors.green : Colors.grey[600],
                      fontSize: 15,
                      backgroundColor: isVisibility ? null : Colors.grey[600]),
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  Strings.APP_EXPENSES,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  isVisibility ? outcoming.formatBRL : Strings.HOME_VALUE,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isVisibility ? Colors.red : Colors.grey[600],
                      fontSize: 15,
                      backgroundColor: isVisibility ? null : Colors.grey[600]),
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
    );
  }
}
