import 'package:flutter/material.dart';
import 'package:proz_project_finance/model/transaction.dart';
import 'package:proz_project_finance/extension/extension_double.dart';

class CardTransaction extends StatelessWidget {
  CardTransaction(this.transaction, {super.key});

  List<Transaction> transaction;

  TextStyle StyleText() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data",
                  style: StyleText(),
                ),
                Text(
                  "Descrição",
                  style: StyleText(),
                ),
                Text(
                  "Valor",
                  style: StyleText(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          returnValee(),
        ],
      ),
    ));
  }

  Widget returnValee() {
    if (transaction.isEmpty) {
      return Center(
        child: Text(
          'Nenhuma transição encontrada',
          style: StyleText(),
        ),
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: transaction.length < 5 ? transaction.length : 5,
          itemBuilder: (context, index) => ListTile(
                leading: Text(
                  "${transaction[index].dateTime?.day}/${transaction[index].dateTime?.month}",
                  style: TextStyle(
                    color: getColor(transaction[index].transactionType),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                title: Center(
                    child: Text(
                  transaction[index].description,
                  style: TextStyle(
                      color: getColor(transaction[index].transactionType),
                      fontWeight: FontWeight.w600),
                )),
                trailing: Text(
                  transaction[index].value.formatBRL,
                  style: TextStyle(
                    color: getColor(transaction[index].transactionType),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ));
    }
  }

  Color getColor(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.INCOME:
        return Colors.green;
      case TransactionType.EXPENSE:
        return Colors.red;
    }
  }
}
