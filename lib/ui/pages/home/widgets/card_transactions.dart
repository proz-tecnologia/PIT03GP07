import 'package:flutter/material.dart';
import 'package:proz_project_finance/model/transaction.dart';
import 'package:proz_project_finance/ui/components/item_transaction.dart';

class CardTransaction extends StatelessWidget {
  CardTransaction(this.transaction, {super.key});

  List<Transaction> transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12),
      elevation: 8,
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          returnValee(),
        ],
      ),
    ));
  }

   Widget returnValee() {
    if (transaction.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma transição encontrada',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: transaction.length < 3 ? transaction.length : 3,
          itemBuilder: (context, index) => ItemTransaction(transaction[index])
      );
    }
  }
}


