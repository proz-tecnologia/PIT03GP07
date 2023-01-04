import 'package:belt/components/list_title.dart';
import 'package:belt/controller/transactions_page.controller.dart';
import 'package:belt/extension/extension_double.dart';
import 'package:belt/model/transaction.model.dart';
import 'package:belt/ui/pages/transactions/widget/item_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/container_empaty.dart';

// ignore: must_be_immutable
class TransactionsPage extends StatefulWidget {
  TransactionsPage(this.listTransaction,this.totalBalance,{super.key});

  final List<Transaction> listTransaction;
  double totalBalance;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late TransactionPageController _controllerPage;

  @override
  void initState() {
    _controllerPage = TransactionPageController(widget.listTransaction);
    _controllerPage.loadListTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Observer(
            builder: (_) => Column(
              children: [
                Row(
                  children: [
                    PopupMenuButton(
                      child: Row(
                        children: [
                          Text(_controllerPage.titlePopup,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 20),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      itemBuilder: (_) => [
                        PopupMenuItem(
                            onTap: () => _controllerPage.setTitlePopup(
                                "Transações", TransactionType.TRANSACTIONS),
                            child: ItemPopup("Transações", Colors.blue)),
                        PopupMenuItem(
                            onTap: () => _controllerPage.setTitlePopup(
                                "Receitas", TransactionType.INCOME),
                            child: ItemPopup("Receitas", Colors.green)),
                        PopupMenuItem(
                            onTap: () => _controllerPage.setTitlePopup(
                                "Despesas", TransactionType.EXPENSE),
                            child: ItemPopup("Despesas", Colors.red)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                        const Icon(Icons.monetization_on_outlined, color: Colors.black38,size: 30),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text("Saldo atual",style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(height: 3),
                            Text(widget.totalBalance.formatBRL)
                          ],
                        )
                      ],),
                    )
                  ],
                ),
                const Divider(height: 20, color: Colors.black38,thickness: 1),
                _controllerPage.getAllTransaction.isEmpty 
                ? const Expanded(child: ContainerEmpaty())
                : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controllerPage.getAllTransaction.length,
                    itemBuilder: (_, index) => ListTitleTransactions(_controllerPage.getAllTransaction, index)
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
