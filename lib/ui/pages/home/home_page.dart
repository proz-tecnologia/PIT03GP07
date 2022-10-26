import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proz_project_finance/controller/transaction_controller.dart';
import 'package:proz_project_finance/model/transaction.dart';
import 'package:proz_project_finance/strings.dart';
import 'package:proz_project_finance/ui/components/item_transaction.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/card_transactions.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/title_body.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/account_balance.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/drawer_menu.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/floating_action.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/movement_value.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisibility = true;

  void changeVisivility() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe8f5ff),
        appBar: AppBar(
          backgroundColor: const Color(0xff1E90FF),
          elevation: 0,
        ),
        drawer: const DrawerMenu(),
        body: Consumer<TransactionController>(
          builder: (context, transactionController, chuld) =>
              SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  height: 165,
                  decoration: const BoxDecoration(
                    color: Color(0xff1E90FF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(
                        20,
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
                          isVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MovimentValue(
                          isVisibility,
                          transactionController.getTotalOutcoming,
                          transactionController.getTotalIncoming),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
               TitleBody(title: "Transações"),
              
              CardTransaction(transactionController.transactions)
              ],
            ),
          ),
        ),
        floatingActionButton: const FloatingButtonAnimate(),
      ),
    );
  }
}
