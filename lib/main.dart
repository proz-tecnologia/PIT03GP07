import 'package:belt/model/transaction.model.dart';
import 'package:belt/ui/pages/home/home.page.dart';
import 'package:belt/ui/pages/newTransaction/new_transaction.page.dart';
import 'package:belt/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home':(context) => const HomePage(),
        '/newIncome':(context) => NewTransaction(TransactionType.INCOME),
        '/newExpense':(context) => NewTransaction(TransactionType.EXPENSE),
      },
    );
  }
}