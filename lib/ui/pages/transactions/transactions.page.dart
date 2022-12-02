import 'package:belt/controller/transactions.controller.dart';
import 'package:belt/extension/extension_double.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TransactionsPage extends StatelessWidget {
  TransactionsPage({required this.controller,super.key});

  TransactionController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: controller.transactions.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(controller.transactions[index].value.formatBRL),
        ),
      );
  }
}