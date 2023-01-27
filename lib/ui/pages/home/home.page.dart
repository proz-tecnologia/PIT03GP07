import 'package:money/ui/components/card_default.dart';
import 'package:money/ui/pages/home/widget/card_balance.dart';
import 'package:money/ui/components/set_month.dart';
import 'package:money/ui/pages/home/widget/card_graphics.dart';
import '../../../controllers/home.controller.dart';
import '../../../controllers/transactions.controller.dart';
import '/extensions/date_time.extension.dart';
import '/extensions/double.extension.dart';
import '/models/transaction.model.dart';
import '/stores/transactions.store.dart';
import '/stores/user.store.dart';
import '/ui/components/custom_alert_dialog.component.dart';
import '/ui/components/progress_dialog.component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controllerTransactions = GetIt.instance.get<TransactionsController>();
  final _homeController = GetIt.instance.get<HomeController>();
  final _userStore = GetIt.instance.get<UserStore>();
  final _transactionsStore = GetIt.instance.get<TransactionsStore>();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    _progressDialog.show("Obtendo dados...");
    await _controllerTransactions.getList();
    await _controllerTransactions.getListCategory();
    _progressDialog.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Image.asset("assets/image/moneybelth.png"),
          ),
        ),
        title: const Text(
          "Money Belt",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Observer(
          builder: (_) => Column(
            children: [
              CardMain(
                CardBalance(
                  _userStore.profile!.firstName,
                  _homeController.isVisibility,
                  _transactionsStore.totalTransactions(),
                  _homeController.setVisivibility,
                  _transactionsStore.totalIncome(),
                  _transactionsStore.totalExpense(),
                ),
              ),
              const SizedBox(height: 10),
              SetMonth(
                  _controllerTransactions.decreaseMonth,
                  _controllerTransactions.increaseMonth,
                  _controllerTransactions.currentDateTime.month,
                  _controllerTransactions.editTitle
                ),
              const SizedBox(height: 10),
              _controllerTransactions.isLoading
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
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Despesa por categoria", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            const SizedBox(height: 10),
                            CardMain(CardChart(
                                transaction: _transactionsStore.listExpense,
                                totalOutcoming:
                                    _transactionsStore.totalExpense())),
                          ],
                        )
            ],
          ),
        ),
      ),
    );
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
