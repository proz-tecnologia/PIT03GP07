import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proz_project_finance/controller/transaction_controller.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/account_balance.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/card_chart.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/card_transactions.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/movement_value.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/title_body.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  bool isVisibility = true;

  void changeVisivility() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionController>(
      builder: (context, transactionController, chuld) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(
                  30,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccontBalance(
                    isVisibility,
                    transactionController.getTotalIncoming -
                        transactionController.getTotalOutcoming),
                IconButton(
                  onPressed: changeVisivility,
                  icon: Icon(
                    isVisibility ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MovimentValue(
                    isVisibility,
                    transactionController.getTotalOutcoming,
                    transactionController.getTotalIncoming),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            height: 5,
          ),
          CardTransaction(
              transactionController.getTotalIncoming -
                  transactionController.getTotalOutcoming,
              transactionController.transactionIncome,
          ),
          // CardChart(transactionController.getTotalOutcoming, transactionController.transactionOutcome)
        ],
      ),
    );
  }
}
