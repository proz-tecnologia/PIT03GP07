import 'package:belt/model/transaction.model.dart';
import 'package:belt/store/user.store.dart';
import 'package:belt/ui/pages/home/home.page.dart';
import 'package:belt/ui/pages/newTransaction/new_transaction.page.dart';
import 'package:belt/ui/pages/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';
import 'ui/pages/login/login_page.dart';

void main() async{
  GetIt.instance.registerSingleton(UserStore());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

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
        '/login': (context) => const LoginPage(),
        '/home':(context) => const HomePage(),
        '/newIncome':(context) => NewTransaction(TransactionType.INCOME),
        '/newExpense':(context) => NewTransaction(TransactionType.EXPENSE),
      },
    );
  }
}