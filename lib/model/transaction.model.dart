// ignore_for_file: constant_identifier_names

import 'package:belt/model/category.model.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  String id = const Uuid().v4();
  TransactionType? transactionType;
  DateTime? dateTime;
  Category category = Category();
  String? description;
  double value = 0.0;

  Transaction(
      {this.transactionType = TransactionType.INCOME,
      this.dateTime,
      required this.category ,
      this.description,
      this.value = 0.0});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = getAllTransactionType(json['transactionType']);
    dateTime = DateTime.parse(json['dateTime']);
    category = Category.fromJson(json['category']);
    description = json['description'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['transactionType'] = transactionType.toString();
    data['dateTime'] = dateTime?.toIso8601String();
    data['category'] = category.toJson();
    data['description'] = description;
    data['value'] = value;
    return data;
  }

  @override
  String toString() {
    return "Transações $id $value $description";
  }

  TransactionType? getAllTransactionType(String item){
    for(TransactionType element in TransactionType.values) {
      if(element.toString() == item) {
        return element;
      }
    }
    return null;
  }
}

enum TransactionType { INCOME, EXPENSE, TRANSACTIONS }