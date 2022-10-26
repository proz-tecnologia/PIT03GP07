// ignore_for_file: constant_identifier_names
import 'package:proz_project_finance/model/category.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  String id = const Uuid().v4();
  TransactionType transactionType;
  DateTime? dateTime;
  Category? category;
  String description;
  double value;

  Transaction(
      {this.transactionType = TransactionType.INCOME,
      this.dateTime,
      this.category,
      this.description = "",
      this.value = 0.0});
}

enum TransactionType { INCOME, EXPENSE }
