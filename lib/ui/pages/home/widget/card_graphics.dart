import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money/models/transaction.model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class CardChart extends StatefulWidget {
  CardChart(
      {required this.transaction, required this.totalOutcoming, super.key});
  List<Transaction> transaction;
  double totalOutcoming;

  @override
  State<CardChart> createState() => _CardChartState();
}

class _CardChartState extends State<CardChart> {
  final _random = Random();

  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.totalOutcoming == 0.0
          ? Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Lottie.asset('assets/lottie/chart.json', height: 80),
                    const SizedBox(height: 20),
                    const Center(
                        child: Text(
                      "Opa! Você não tem despesas cadastradas",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )),
                    const SizedBox(height: 10),
                    const Center(
                        child: Text(
                      "Adicione seus gastos para ver seu gráfico.",
                      style: TextStyle(fontSize: 14),
                    ))
                  ]),
            )
          : SizedBox(
            height: 110,
            child: SfCircularChart(
                centerX: "50",
                centerY: "50",
                tooltipBehavior: _tooltip,
                legend: Legend(isVisible: true, position: LegendPosition.right, isResponsive: true, alignment: ChartAlignment.far),
                series: [
                  DoughnutSeries(
                    radius: "50",
                    innerRadius: "20",
                    explode: true,
                    dataSource: widget.transaction,
                    xValueMapper: (_, index) =>
                        widget.transaction[index].category!.name,
                    yValueMapper: (_, index) =>
                        (widget.transaction[index].value /
                            widget.totalOutcoming) *
                        100,
                    dataLabelMapper: (_, index) =>
                        '${((widget.transaction[index].value / widget.totalOutcoming) * 100).toStringAsFixed(0)}%',
                    pointColorMapper: (_, index) =>
                        Colors.primaries[_random.nextInt(Colors.primaries.length)]
                            [_random.nextInt(9) * 100],
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
          ),
    );
  }
}
