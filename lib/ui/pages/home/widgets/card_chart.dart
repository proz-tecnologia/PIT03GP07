import 'package:flutter/material.dart';
import 'package:proz_project_finance/model/chart_data.dart';
import 'package:proz_project_finance/model/transaction.dart';

class CardChart extends StatefulWidget {
  CardChart(this.totalOutcoming,this.transactionOutcome,{super.key});

  double totalOutcoming;
  List<Transaction> transactionOutcome;

  @override
  State<CardChart> createState() => _CardChartState();
}

class _CardChartState extends State<CardChart> {
  
@override
  Widget build(BuildContext context) {
    final getCategory = totalCategory();
    double conta = (getCategory / widget.totalOutcoming) * 100;
    
    return ElevatedButton(onPressed: () => print(conta.toStringAsFixed(0)), child: Text("ola"));
  }

  double totalCategory(){
    double value = 0;
    var filtred = widget.transactionOutcome.where((element) => element.category!.name == "Alimentação");
    for (var transaction in filtred) {
      value += transaction.value;
    }
    return value;
  }
}