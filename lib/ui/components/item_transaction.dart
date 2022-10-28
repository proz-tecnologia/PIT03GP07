import 'package:flutter/material.dart';
import 'package:proz_project_finance/extension/extension_double.dart';
import 'package:proz_project_finance/model/transaction.dart';

class ItemTransaction extends StatefulWidget {
  Transaction transaction;

  ItemTransaction(this.transaction, {super.key});

  @override
  State<ItemTransaction> createState() => _ItemTransactionState();
}

class _ItemTransactionState extends State<ItemTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Text(
          "${widget.transaction.dateTime?.day}/${widget.transaction.dateTime?.month}",
          style: TextStyle(color: getColor(), fontWeight: FontWeight.w600),
        ),
        title: Center(
          child: Column(
            children: [
              Text(widget.transaction.description,
              style: TextStyle(color: getColor(), fontWeight: FontWeight.w600)),
              Text(widget.transaction.category!.name, style: TextStyle(fontSize: 10),),
            ],
          )
        ),
        trailing: Text(getValue(), style: TextStyle(color: getColor(), fontWeight: FontWeight.w600)),
      ),
    );
  }

  Color getColor() {
    switch (widget.transaction.transactionType) {
      case TransactionType.INCOME:
        return Colors.green;
      case TransactionType.EXPENSE:
        return Colors.red;
    }
  }

  String getValue() {
    switch (widget.transaction.transactionType) {
      case TransactionType.INCOME:
        return widget.transaction.value.formatBRL;
      case TransactionType.EXPENSE:
        return "(${widget.transaction.value.formatBRL})";
    }
  }
}