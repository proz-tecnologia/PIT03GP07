import 'package:flutter/material.dart';
import 'package:proz_project_finance/model/transaction.dart';

class ItemList extends StatelessWidget {
  ItemList(this.transaction,{super.key});

  Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Text("${transaction.dateTime?.day}/${transaction.dateTime?.month}");
  }
}
