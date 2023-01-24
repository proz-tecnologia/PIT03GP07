import 'package:money/ui/components/card_default.dart';

import '/controllers/home.controller.dart';
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
  final _controller = GetIt.instance.get<HomeController>();
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
    await _controller.getList();
    await _controller.getListCategory();
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
          actions: [
            IconButton(onPressed: _logout, icon: const Icon(Icons.exit_to_app))
          ],
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Observer(
            builder: (_) => Column(
              children: [
                CardDefault(
                  _userStore.profile!.firstName,
                  _controller.isVisibility,
                  _transactionsStore.totalTransactions(),
                  _controller.setVisivibility,
                  _transactionsStore.totalIncome(),
                  _transactionsStore.totalExpense(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _controller.decreaseMonth,
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      "${_returnMonth(_controller.currentDateTime.month)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    IconButton(
                      onPressed: _controller.increaseMonth,
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _controller.isLoading
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
                            Lottie.asset('assets/lottie/money.json', height: 300)
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
                                      trailing: Text(_transactionsStore
                                          .list[index].value.toBRL),
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
        bottomNavigationBar: StylishBottomBar(
          padding: const EdgeInsets.all(8),
          fabLocation: StylishBarFabLocation.center,
          bubbleFillStyle: BubbleFillStyle.fill,
          barStyle: BubbleBarStyle.vertical,
          hasNotch: true,
          items: [
            BubbleBarItem(
              backgroundColor: Colors.white,
              icon: const Icon(Icons.home_outlined),
              title: const Text("home", style: TextStyle(color: Colors.black)),
              activeIcon: const Icon(Icons.home, color: Colors.black),
            ),
            BubbleBarItem(
                backgroundColor: Colors.white,
                icon: const Icon(Icons.list_outlined, color: Colors.black),
                activeIcon: const Icon(Icons.list, color: Colors.black),
                title: const Text("Transações",
                    style: TextStyle(color: Colors.black)))
          ],
          onTap: (value) {
            //   setState(() {
            //     pageCurrent = value!;
            //   });
            //   controllerPage.animateToPage(
            //     value!,
            //     duration: const Duration(microseconds: 200),
            //     curve: Curves.easeInOut,
            //   );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          direction: SpeedDialDirection.up,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.green,
              label: "Nova receita",
              child: const Icon(Icons.arrow_drop_down),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/add-income"),
            ),
            SpeedDialChild(
              backgroundColor: Colors.red,
              label: "Nova despesa",
              child: const Icon(Icons.arrow_drop_down),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/add-expense"),
            )
          ],
        ));
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/login");
  }

  _removeTransaction(Transaction item) async {
    _progressDialog.show("Excluindo...");
    final response = await _controller.removeTransaction(item);
    _progressDialog.hide();
    if (response.isError) {
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }

  _returnMonth(int month) {
    switch (month) {
      case (1):
        return "Janeiro";
      case (2):
        return "Fevereiro";
      case (3):
        return "Março";
      case (4):
        return "Abril";
      case (5):
        return "Maio";
      case (6):
        return "Junho";
      case (7):
        return "Julho";
      case (8):
        return "Agosto";
      case (9):
        return "Setembro";
      case (10):
        return "Outubro";
      case (11):
        return "Novembro";
      case (12):
        return "Dezembro";
    }
  }
}
