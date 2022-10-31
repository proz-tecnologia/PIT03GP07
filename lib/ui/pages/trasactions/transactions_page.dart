import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proz_project_finance/controller/transaction_controller.dart';
import 'package:proz_project_finance/ui/components/item_transaction.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8f5ff),
      body: Consumer<TransactionController>(
          builder: (context, transactionController, index) => SingleChildScrollView(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:const  [
                        Text(
                          "Data",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Descrição",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Valor",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                 ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactionController.transactions.length,
                  itemBuilder: (context, index) => ItemTransaction(transactionController.transactions[index])
                )
                ],
              ),
          )
        ),
    );
  }
  
}
