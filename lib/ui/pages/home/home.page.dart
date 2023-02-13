import 'package:money/extensions/double.extension.dart';
import 'package:money/ui/components/card_default.dart';
import 'package:money/ui/pages/home/widget/card_balance.dart';
import 'package:money/ui/components/set_month.dart';
import 'package:money/ui/pages/home/widget/card_graphics.dart';
import '../../../controllers/add_wishe.controller.dart';
import '../../../controllers/home.controller.dart';
import '../../../controllers/transactions.controller.dart';
import '../../../stores/wishe.store.dart';
import '/stores/transactions.store.dart';
import '/stores/user.store.dart';
import '/ui/components/progress_dialog.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

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
  final _controllerWishestore = GetIt.instance.get<WisheStore>();
  final _controllerWishe = GetIt.instance.get<AddWisheController>();

  final _progressDialog = ProgressDialog();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    _progressDialog.show("Obtendo dados...");
    await _controllerTransactions.getList();
    await _controllerTransactions.getListCategory();
    await _controllerWishe.getList();
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
            child: IconButton(icon: Image.asset("assets/image/moneybelth.png"), onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },),
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
                  _controllerTransactions.editTitle),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
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
                                  const Text(
                                    "Despesa por categoria",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  CardMain(CardChart(
                                      transaction: _transactionsStore.listExpense,
                                      totalOutcoming:
                                          _transactionsStore.totalExpense())),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Desejos",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  _controllerWishestore.list.isEmpty
                                      ? CardMain(Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const Center(
                                              child: Text(
                                                  "Você não tem desejo cadastrado.",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Lottie.asset(
                                                'assets/lottie/wishe2.json',
                                                height: 150,
                                                width: 150),
                                            const SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: _toAddWishe,
                                              child: const Text(
                                                "Adiconar um novo desejo",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ))
                                      : CardMain(Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Center(
                                                          child: Text(
                                                              "Desejos Cadastrados",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))),
                                                      const SizedBox(height: 10),
                                                      Center(
                                                          child: Text(
                                                              "${_controllerWishestore.list.length}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Center(
                                                          child: Text(
                                                              "Total valor desejado",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))),
                                                      const SizedBox(height: 10),
                                                      Center(
                                                          child: Text(
                                                              totalWishes(),
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            ElevatedButton(
                                              onPressed: _toAddWishe,
                                              child: const Text(
                                                "Adiconar um novo desejo",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        )),
                                        const SizedBox(height: 35),
                                ],
                              )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String totalWishes() {
    double total = _controllerWishestore.totalWishes();
    return _homeController.isVisibility
        ? total.toBRL
        : total.toBRL.replaceAll(RegExp(r'[0-9]'), 'X');
  }

  _toAddWishe() {
    Navigator.pushNamed(context, '/add-wishe');
  }
}
