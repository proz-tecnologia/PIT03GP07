import 'package:belt/extension/extension_double.dart';
import 'package:belt/model/transaction.model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListTitleTransactions extends StatelessWidget {
  ListTitleTransactions(this.transactions, this.index, {super.key});
  List<Transaction> transactions;
  int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "${transactions[index].dateTime!.day} / ${transactions[index].dateTime!.month}",
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      title: Text(transactions[index].description!.isEmpty
          ? transactions[index].category.name
          : transactions[index].description.toString()),
      subtitle: Text(transactions[index].category.name.toUpperCase(),
          style: const TextStyle(fontSize: 12)),
      trailing: Text(
        transactions[index].value.formatBRL,
        style: TextStyle(
          color: colorSelect(transactions[index].transactionType!),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  MaterialColor colorSelect(TransactionType type) {
    if (type == TransactionType.INCOME) return Colors.green;
    return Colors.red;
  }
}
