import 'dart:math';

import 'package:proz_project_finance/model/category.dart';
import 'package:proz_project_finance/model/transaction.dart';
import 'package:proz_project_finance/util/random_util.dart';

abstract class TransactionMock {
  static List<Transaction> generateTransactions(
      int size, List<Category> categories) {
    return List<Transaction>.generate(size, (index) {
      categories.shuffle();
      return Transaction(
          transactionType: TransactionType.values[Random().nextInt(2)],
          dateTime: RandomUtil.generateRandomDate(
              DateTime.now().subtract(const Duration(days: 30)), 30),
          category: categories.first,
          description:
              "Transacion #${Random().nextInt(100).toString().padLeft(3, '0')}",
          value: Random().nextDouble() * 1000);
    });
  }
}
