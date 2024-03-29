import 'package:money/controllers/add_wishe.controller.dart';
import 'package:money/controllers/content.page.controller.dart';
import 'package:money/controllers/home.controller.dart';
import 'package:money/infra/repositories/wishe.repository_impl.dart';
import 'package:money/infra/services/wishe.service.dart';
import 'package:money/stores/wishe.store.dart';
import 'package:money/ui/pages/add_new_wishe/new.wishe.page.dart';
import 'package:money/ui/pages/content.page.dart';
import 'package:money/ui/pages/profile/profile.page.dart';
import 'package:money/ui/pages/transactions/transactions.page.dart';

import '/controllers/add_category.controller.dart';
import '/controllers/add_transaction.controller.dart';
import 'controllers/transactions.controller.dart';
import '/controllers/login.controller.dart';
import '/controllers/register.controller.dart';
import '/controllers/splash.controller.dart';
import '/firebase_options.dart';
import '/infra/repositories/auth.repository_impl.dart';
import '/infra/repositories/category.repository_impl.dart';
import '/infra/repositories/profile.repository_impl.dart';
import '/infra/repositories/transaction.repository_impl.dart';
import '/infra/services/auth.service.dart';
import '/infra/services/category.service.dart';
import '/infra/services/profile.service.dart';
import '/infra/services/transaction.service.dart';
import '/navigator_key.dart';
import '/stores/category.store.dart';
import '/stores/transactions.store.dart';
import '/stores/user.store.dart';
import '/ui/pages/addTransaction/add_transaction.page.dart';
import 'ui/pages/home/home.page.dart';
import 'ui/pages/login/login.page.dart';
import 'ui/pages/register/register.page.dart';
import 'ui/pages/splash/splash.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.instance.registerSingleton(UserStore());
  GetIt.instance.registerSingleton(TransactionsStore());
  GetIt.instance.registerSingleton(CategoryStore());
  GetIt.instance.registerSingleton(WisheStore());

  GetIt.instance.registerFactory(
    () => SplashController(AuthRepositoryImpl(AuthService()),
        ProfileRepositoryImpl(ProfileService())),
  );
  GetIt.instance.registerFactory(
    () => LoginController(AuthRepositoryImpl(AuthService()),
        ProfileRepositoryImpl(ProfileService())),
  );
  GetIt.instance.registerFactory(
    () => RegisterController(AuthRepositoryImpl(AuthService()),
        ProfileRepositoryImpl(ProfileService())),
  );
  GetIt.instance.registerFactory(
    () => TransactionsController(
      TransactionRepositoryImpl(TransactionService()),CategoryRepositoryImpl(CategoryService())),
  );
  GetIt.instance.registerFactory(
    () => AddTransactionController(
        TransactionRepositoryImpl(TransactionService())),
  );
  GetIt.instance.registerFactory(
    () => AddWisheController(WisheRepositoryImpl(WisheService())),
  );
  GetIt.instance.registerFactory(
    () => AddCategoryController(
        CategoryRepositoryImpl(CategoryService()),CategoryRepositoryImpl(CategoryService())),
  );
  GetIt.instance.registerFactory(() => HomeController());
  GetIt.instance.registerFactory(() => ContentPageController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashPage(),
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
        '/content': (_) =>const  ContentPage(),
        '/home': (_) => const HomePage(),
        '/transctions': (_) => const TransactionsPage(),
        '/add-income': (_) => const AddTransactionPage(transactionType: "INCOME"),
        '/add-expense': (_) =>const  AddTransactionPage(transactionType: "EXPENSE"),
        '/add-wishe': (_) =>const  AddNewWishe(),
        '/profile': (_) =>const  ProfilePage(),
      },
    );
  }
}
