import 'package:flutter/material.dart';
import 'package:proz_project_finance/extension/extension_double.dart';
import 'package:proz_project_finance/model/transaction.dart';
import 'package:proz_project_finance/strings.dart';
import 'package:proz_project_finance/ui/components/item_transaction.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/title_body.dart';

class CardTransaction extends StatelessWidget {
  CardTransaction(this.totalIncoming, this.transaction, {super.key});

  double totalIncoming;
  List<Transaction> transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: TitleBody(Strings.APP_REVENUES),
      SizedBox(
        height: 5,
      ),
      Card(
        margin: EdgeInsets.symmetric(horizontal: 12),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 218, 218, 218),
                            width: 1))),
                child: Row(
                  children: [
                    Expanded(child: Icon(Icons.attach_money_outlined)),
                    Expanded(
                      flex: 10,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              Strings.HOME_BALANCE,),
                              Text(totalIncoming.formatBRL),
                            ),
                          ])),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(Strings.HOME_NEWINCOME),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              returnValee(),
            ],
          ),
        ),
      ),
    );
  }

  Widget returnValee() {
    if (transaction.isEmpty) {
      return Column(
        children: [
          const Center(
            child: Text(
              Strings.HOME_NEWREVENUES,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: transaction.length < 3 ? transaction.length : 3,
          itemBuilder: (context, index) => ItemTransaction(transaction[index]));
    }
  }
}
