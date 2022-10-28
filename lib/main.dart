import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proz_project_finance/controller/transaction_controller.dart';
import 'package:proz_project_finance/model/transaction.dart';
import 'package:proz_project_finance/ui/pages/home/home_page.dart';
import 'package:proz_project_finance/ui/pages/new_revenue/new_transaction_page.dart';
import 'package:proz_project_finance/ui/pages/splash/splash_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TransactionController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const HomePage(),
        '/splash':(context) => const SplashPage(),
        '/new-income':(context) => NewTransactionPage(TransactionType.INCOME),
        '/new-expense':(context) => NewTransactionPage(TransactionType.EXPENSE),
      },
    );
  }
}