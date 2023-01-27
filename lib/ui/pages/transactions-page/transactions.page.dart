import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:money/controllers/transactions.controller.dart';
import 'package:money/extensions/date_time.extension.dart';
import 'package:money/ui/components/set_month.dart';
import '../../../models/transaction.model.dart';
import '../../../stores/transactions.store.dart';
import '../../components/custom_alert_dialog.component.dart';
import '../../components/progress_dialog.component.dart';
import 'widget/popup_item.dart';
import 'package:money/extensions/double.extension.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final _controllerTransactions = GetIt.instance.get<TransactionsController>();
  final _transactionsStore = GetIt.instance.get<TransactionsStore>();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(
          builder: (_) => SafeArea(
            child: Column(
              children: [
                PopupMenuButton(
                  child: Row(
                    children: [
                      Text(_controllerTransactions.titlePopup,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 20),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                        onTap: () => _controllerTransactions.setTitlePopup(
                            "Transações", "Transações"),
                        child: ItemPopup("Transações", Colors.blue)),
                    PopupMenuItem(
                        onTap: () => _controllerTransactions.setTitlePopup(
                            "Receitas", "Receitas"),
                        child: ItemPopup("Receitas", Colors.green)),
                    PopupMenuItem(
                        onTap: () => _controllerTransactions.setTitlePopup(
                            "Despesas", "Despesas"),
                        child: ItemPopup("Despesas", Colors.red)),
                  ],
                ),
                const SizedBox(height: 20),
                SetMonth(
                  _controllerTransactions.decreaseMonth,
                  _controllerTransactions.increaseMonth,
                  _controllerTransactions.currentDateTime.month,
                  _controllerTransactions.editTitle
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 30),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Balanço mensal",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Text(_transactionsStore.totalTransactions().toBRL,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ],
                    ),
                    _controllerTransactions.titlePopup == "Receitas"
                        ? Row(children: [
                          const SizedBox(width: 20),
                            const Icon(
                                    Icons.arrow_upward_outlined,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Receita",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Text(
                                    _transactionsStore
                                        .totalIncome()
                                        .toBRL,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ])
                        : _controllerTransactions.titlePopup == "Despesas"
                            ? Row(children: [
                              const SizedBox(width: 20),
                                const Icon(
                                    Icons.arrow_downward_outlined,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Despesa",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                        _transactionsStore
                                            .totalExpense()
                                            .toBRL,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ])
                            : SizedBox()
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1,indent: 30,endIndent: 30),
                const SizedBox(height: 10),
                Expanded(
                  child: _controllerTransactions.isLoading
                      ? const SizedBox(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.blue,
                          )),
                        )
                      : _transactionsStore.list.isEmpty
                          ? Column(
                              children: [
                                const Center(
                                    child: Text(
                                  "Nenhuma transação registrada!",
                                  style: TextStyle(fontSize: 16),
                                )),
                                Lottie.asset('assets/lottie/money.json',
                                    height: 300)
                              ],
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 64),
                              itemCount: _transactionsStore.count,
                              itemBuilder: (_, index) => Dismissible(
                                key: ValueKey<Transaction>(
                                    _transactionsStore.list[index]),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                ),
                                onDismissed: (direction) {
                                  _removeTransaction(
                                      _transactionsStore.list[index]);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(_transactionsStore
                                          .list[index].description),
                                      subtitle: Text(_transactionsStore
                                          .list[index].date!.toBRLDate),
                                      trailing: Text(
                                        _transactionsStore
                                            .list[index].value.toBRL,
                                        style: TextStyle(
                                            color: colorSelect(
                                                _transactionsStore.list[index]
                                                    .typeTransaction!),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialColor colorSelect(String type) {
    if (type == "INCOME") return Colors.green;
    return Colors.red;
  }

  _removeTransaction(Transaction item) async {
    _progressDialog.show("Excluindo...");
    final response = await _controllerTransactions.removeTransaction(item);
    _progressDialog.hide();
    if (response.isError) {
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }
}
