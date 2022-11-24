import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/movement_value.dart';
import 'package:proz_project_finance/extension/extension_double.dart';

import '../../../../strings.dart';

class AccontBalance extends StatelessWidget {
  double _balance;
  bool isVisibility;
  AccontBalance(this.isVisibility, this._balance, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          Strings.HOME_LABEL_BALANCE,
          style: TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            _balance.formatBRL,
            style: TextStyle(
                color: isVisibility ? Colors.black : Colors.grey[600],
                fontSize: 20,
                backgroundColor: isVisibility ? null : Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
